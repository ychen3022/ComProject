//
//  BarCodeScanViewController.m
//  二维码生成与扫描
//
//  Created by ychen on 16/12/20.
//  Copyright © 2016年 ychen. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BarCodeScanViewController.h"
#import "UIView+Ext.h"


#define screen_H [UIScreen mainScreen].bounds.size.height
#define screen_W [UIScreen mainScreen].bounds.size.width
#define maskViewBoard_W 30
#define maskViewScaleX 0.5
#define maskViewScaleY 0.4
#define iOS8_later [[UIDevice currentDevice].systemVersion floatValue] >= 8.0


@interface BarCodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
/** 遮罩层*/
@property (nonatomic, strong)UIView *maskView;
/** 扫描窗口视图*/
@property (nonatomic, strong)UIView *scanWindowView;
/** 扫描窗口网状图片*/
@property (nonatomic, strong)UIImageView *scanNetImageView;
/** 拍摄会话*/
@property (nonatomic, strong)AVCaptureSession *captureSession;
/** 拍摄图层*/
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *videoPreviewLayer;
/** 计时器*/
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation BarCodeScanViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self resumeAnimation:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    self.view.clipsToBounds=YES; // 这个属性必须打开否则返回的时候会出现黑边
    
    //1.遮罩层
    [self setupMaskView];
    
    //2.扫描窗口
    [self setupScanWindowView];
    
    //3.上边框
    [self setupNavView];
    
    //4.下边框
    [self setupBottomBarView];
    
    //5.开始扫描
    [self beginScanning];
    
}

#pragma mark -二维码扫描动画 YES开启动画  NO 暂停动画
- (void)resumeAnimation:(BOOL)startOrStop{
    if(startOrStop){  //开始动画
        CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
        if(anim){
            // 1. 将动画的时间偏移量作为暂停时的时间点
            CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
            // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
            CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
            // 3. 要把偏移时间清零
            [_scanNetImageView.layer setTimeOffset:0.0];
            // 4. 设置图层的开始动画时间
            [_scanNetImageView.layer setBeginTime:beginTime];
            // 5. 设置动画的速度
            [_scanNetImageView.layer setSpeed:1.0];
            
        }else{
            
            CGFloat scanNetImageViewW = _scanWindowView.width;
            CGFloat scanNetImageViewH = 240;
            CGFloat scanWindowViewWH = self.view.width - maskViewBoard_W * 2;
            _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
           
            CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
            scanNetAnimation.keyPath = @"transform.translation.y";
            scanNetAnimation.byValue = @(scanWindowViewWH);
            scanNetAnimation.duration = 2.0;
            scanNetAnimation.repeatCount = MAXFLOAT;
            [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
            [_scanWindowView addSubview:_scanNetImageView];
            
        }
        
    }else{//停止动画
        
        CFTimeInterval pauseTime = [_scanNetImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
        _scanNetImageView.layer.timeOffset = pauseTime;
        //3.将动画的运行速度设置为0， 默认的运行速度是1.0
        [_scanNetImageView.layer setSpeed:0.0];
    }
}


#pragma mark -遮罩层
- (void)setupMaskView{
    _maskView =[[UIView alloc] initWithFrame:CGRectMake(0,0,screen_W,screen_W)];
    _maskView.center=CGPointMake(screen_W * maskViewScaleX, screen_H * maskViewScaleY);
    _maskView.layer.borderWidth = maskViewBoard_W;
    _maskView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    [self.view addSubview:_maskView];
    
    UIView *topMaskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_W, screen_H * maskViewScaleY -screen_W * maskViewScaleX)];
    topMaskView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:topMaskView];
    
    UIView *bottomMaskView=[[UIView alloc] initWithFrame:CGRectMake(0,screen_H*maskViewScaleY +(1-maskViewScaleX)*screen_W, screen_W, (1-maskViewScaleY) * screen_H - (1-maskViewScaleX) * screen_W )];
    bottomMaskView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:bottomMaskView];
}


#pragma mark -扫描窗口
- (void)setupScanWindowView{
    
    CGFloat scanWindowViewWH = screen_W -maskViewBoard_W *2;
    CGFloat buttonWH = 19;
   
    //创建整个扫描视图
    _scanWindowView= [[UIView alloc] initWithFrame:CGRectMake(maskViewBoard_W,screen_H * maskViewScaleY -screen_W * maskViewScaleX + maskViewBoard_W, scanWindowViewWH, scanWindowViewWH)];
    _scanWindowView.clipsToBounds = YES;
    [self.view addSubview:_scanWindowView];
    
    //上下左右四个角上的图标
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindowView addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowViewWH - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindowView addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowViewWH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindowView addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowViewWH-buttonWH, scanWindowViewWH-buttonWH, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindowView addSubview:bottomRight];
    
    //扫描视图下方的提示语
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _scanWindowView.top+_scanWindowView.height, screen_W, 30)];
    tipLabel.text = @"将取景框对准二维码，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    
    //扫描网状照片
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
}





#pragma mark -上边框
-(void)setupNavView{
    
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(30, 30, 25, 25);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    backBtn.contentMode=UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //相册按钮
    UIButton *albumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.frame = CGRectMake(screen_W-100, 30, 32.5, 43.5);
    [albumBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateNormal];
    albumBtn.contentMode=UIViewContentModeScaleAspectFit;
    [albumBtn addTarget:self action:@selector(albumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumBtn];
    
    //闪光灯按钮
    UIButton * flashBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    flashBtn.frame = CGRectMake(screen_W-60,30, 32.5, 43.5);
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(flashBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashBtn];
}

#pragma mark -返回按钮
-(void)backBtnAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -我的相册
-(void)albumBtnAction:(UIButton *)btn{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        //2.设置代理
        imagePickerController.delegate=self;
        //3.设置资源：
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //4.随便给他一个转场动画
        imagePickerController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        imagePickerController.allowsEditing=YES;
        [self presentViewController:imagePickerController animated:YES completion:NULL];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *pickImage =[info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImageWriteToSavedPhotosAlbum(pickImage, nil, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self decodeImage:pickImage];
    }];
}

#pragma mark -识别图片中的二维码信息
-(void)decodeImage:(UIImage*)image{
    if(iOS8_later){ //ios8环境以上
        //初始化一个监测器
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            
            [self resumeAnimation:NO];
            [_captureSession stopRunning];
            
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.tag=2;
            [alertView show];
            
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else{//ios8环境以下
//        CGImageRef imageToDecode = image.CGImage;
//        ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
//        CGImageRelease(imageToDecode);
//        ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
//        NSError *error = nil;
//        ZXDecodeHints *hints = [ZXDecodeHints hints];
//        
//        ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
//        ZXResult *result = [reader decode:bitmap
//                                    hints:hints
//                                    error:&error];
//        if (result) {
//            NSString *contents = result.text;
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"解析成功" message:contents delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alterView show];
//        } else {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"解析失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alterView show];
//        }
    }
}

#pragma mark -闪光灯
-(void)flashBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self turnTorchOn:YES];
    }else{
        [self turnTorchOn:NO];
    }
}

- (void)turnTorchOn:(BOOL)on{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}



#pragma mark -下边框
- (void)setupBottomBarView{
    //我的二维码
    UIButton * myCodeBtn=[[UIButton alloc] initWithFrame:CGRectMake((screen_W-32.5)/2,screen_H-100, 32.5, 43.5)];
    [myCodeBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateNormal];
    myCodeBtn.contentMode=UIViewContentModeScaleAspectFit;
    [myCodeBtn addTarget:self action:@selector(myCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myCodeBtn];
}

-(void)myCodeBtnAction:(UIButton *)btn{
    NSLog(@"我的二维码");
}


#pragma mark -开始扫描
- (void)beginScanning{
    NSError *error;
    //初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo,该类型可以快速使用设备的摄像头部分
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input){
      return;
    }
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    
    //初始化拍摄会话对象
    _captureSession = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    [_captureSession addInput:input];
    [_captureSession addOutput:output];
    
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _videoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    _videoPreviewLayer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    //开始捕获
    [_captureSession startRunning];
    
    //设置有效的扫描区域
    CGRect intertRect = [_videoPreviewLayer metadataOutputRectOfInterestForRect:_scanWindowView.bounds];
    CGRect layerRect = [_videoPreviewLayer rectForMetadataOutputRectOfInterest:intertRect];
    output.rectOfInterest = layerRect;
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [_captureSession stopRunning];
        [self resumeAnimation:NO];
        AVMetadataMachineReadableCodeObject *metadataObject=[metadataObjects objectAtIndex:0];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"再次扫描", nil];
        alert.tag=1;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        } else if (buttonIndex == 1) {
            [self resumeAnimation:YES];
            [_captureSession startRunning];
        }
    }
    if(alertView.tag==2){
        [_captureSession startRunning];
        [self resumeAnimation:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



