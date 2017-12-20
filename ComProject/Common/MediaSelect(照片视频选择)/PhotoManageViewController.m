//
//  PhotoManageViewController.m
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "PhotoManageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "MediaManageView.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "MediaModel.h"

@interface PhotoManageViewController ()<MediaManageViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) MediaManageView *mediaManageView;
@property (nonatomic, strong) NSMutableArray *selectPhotoArr;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation PhotoManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"照片选择";
    [self creatSubView];
}

-(void)creatSubView{
    self.mediaManageView=[[MediaManageView alloc] initWithFrame:CGRectMake(0, 0,KScreenW, KScreenH)];
    self.mediaManageView.delegate=self;
    self.mediaManageView.maxCount=9;
    self.mediaManageView.dataArr=self.selectPhotoArr;
    self.mediaManageView.mediaManageType=MediaManageType_Edit;
    [self.view addSubview:self.mediaManageView];
}

-(void)mediaManageView:(MediaManageView *)mediaManageView didAddCell:(MediaCollectionViewCell *)cell{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"标题" message:@"请拍摄照片或者从相册选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectPhoto];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -选择照片
-(void)selectPhoto{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    //四类个性化设置，这些参数都可以不传，此时会走默认设置
    
    //在这里设置imagePickerVC的外观
//    imagePickerVC.navigationBar.barTintColor = [UIColor greenColor];
//    imagePickerVC.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
//    imagePickerVC.oKButtonTitleColorNormal = [UIColor greenColor];
//    imagePickerVC.navigationBar.translucent = NO;
    
    
//    imagePickerVC.isSelectOriginalPhoto = YES;//是否选择原图
//    imagePickerVC.selectedAssets = self.selectPhotoArr; //是否显示目前已经选中的图片数组
//    imagePickerVC.allowTakePicture = YES; // 是否在内部显示拍照按钮
    
    
    //设置是否可以选择视频/图片/原图
//    imagePickerVC.allowPickingVideo = YES; //是否允许选择视频
//    imagePickerVC.allowPickingImage = YES; //是否允许选择照片
//    imagePickerVC.allowPickingOriginalPhoto = YES; //是否允许选择原图;
//    imagePickerVC.allowPickingGif = YES; //是否允许选择gif
    
    
    //照片排列按修改时间升序
//    imagePickerVC.sortAscendingByModificationDate = YES;
//    imagePickerVC.minImagesCount = 3;//最少选择照片数量
//    imagePickerVC.alwaysEnableDoneBtn = YES;
//    imagePickerVC.minPhotoWidthSelectable = 3000;
//    imagePickerVC.minPhotoHeightSelectable = 2000;
    
    
    //单选模式,maxImagesCount为1时才生效
//    imagePickerVC.showSelectBtn = NO;
//    imagePickerVC.allowCrop = YES;
//    imagePickerVC.needCircleCrop = YES;
//    imagePickerVC.circleCropRadius = 100;
//    imagePickerVC.isStatusBarDefault = NO;
    /*
         [imagePickerVC setCropViewSettingBlock:^(UIView *cropView) {
         cropView.layer.borderColor = [UIColor redColor].CGColor;
         cropView.layer.borderWidth = 2.0;
         }];
     */
    
//    imagePickerVC.allowPreview = YES;
    
    //通过block的方法来得到用户选择的照片，还可以使用代理
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


#pragma mark -TZImagePickerController选择照片代理
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    for (int index = 0; index < photos.count; index++) {
        MediaModel *selectModel=[[MediaModel alloc] init];
        selectModel.coverPhoto=photos[index];
        selectModel.asset=assets[index];
        selectModel.mediaType=MediaType_Photo;
        selectModel.mediaCellState=MediaCellState_Normal;
        [self.selectPhotoArr addObject:selectModel];
    }
    [self.mediaManageView reloadData];
}

#pragma mark -TZImagePickerController选择视频代理(只能单选)
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    MediaModel *selectModel=[[MediaModel alloc] init];
    selectModel.coverPhoto=coverImage;
    selectModel.asset=asset;
    selectModel.mediaType=MediaType_Video;
    selectModel.mediaCellState=MediaCellState_Normal;
    [self.selectPhotoArr addObject:selectModel];
    [self.mediaManageView reloadData];
}

#pragma mark -TZImagePickerController选择gif图片代理(只能单选)
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset{
    
}


#pragma mark -拍摄照片
-(void)takePhoto{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

- (void)pushImagePickerController {
    // 提前定位
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
        _location = location;
    } failureBlock:^(NSError *error) {
        _location = nil;
    }];
    
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickerVC.delegate = self;
    imagePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    imagePickerVC.allowsEditing =YES;//自定义照片样式
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark -UIImagePickerController拍摄图片代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //保存照片到本地相册
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"] && picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(originalImage,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    }
    UIImage *coverImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    MediaModel *selectModel=[[MediaModel alloc] init];
    selectModel.coverPhoto=coverImage;
    selectModel.mediaType=MediaType_Photo;
    selectModel.mediaCellState=MediaCellState_Normal;
    [self.selectPhotoArr addObject:selectModel];
    [self.mediaManageView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}




-(NSMutableArray *)selectPhotoArr{
    if (_selectPhotoArr==nil) {
        _selectPhotoArr=[NSMutableArray array];
    }
    return _selectPhotoArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
