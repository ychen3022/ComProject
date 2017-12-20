//
//  MediaImagePickerController.m
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/12.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "MediaImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface MediaImagePickerController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MediaImagePickerController

- (void)viewDidLoad{
    [super viewDidLoad];
    if (![self isVideoRecordingAvailable]) {
        return;
    }
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.mediaTypes = @[(NSString *)kUTTypeMovie];
    self.delegate = self;
    
    //    //隐藏系统自带UI
    //    self.showsCameraControls = YES;
    //    //设置摄像头
    //    [self switchCameraIsFront:NO];
    //    //设置视频画质类别
    self.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //    //设置散光灯类型
    //    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    //    //设置录制的最大时长
    self.videoMaximumDuration = 60;
    
    
//    _pickerController=[[UIImagePickerController alloc] init];
//    _pickerController.delegate = self;
//    _pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
//    _pickerController.cameraDevice=UIImagePickerControllerCameraDeviceRear;
//    _pickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
//    _pickerController.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
//    _pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
//    _pickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
//    _pickerController.videoQuality=UIImagePickerControllerQualityTypeHigh;
//    _pickerController.allowsEditing = YES; // 允许编辑
    
    
}









#pragma mark - Private methods
- (BOOL)isVideoRecordingAvailable{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if([availableMediaTypes containsObject:(NSString *)kUTTypeMovie]){
            return YES;
        }
    }
    return NO;
}

- (void)switchCameraIsFront:(BOOL)front{
    if (front) {
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]){
            [self setCameraDevice:UIImagePickerControllerCameraDeviceFront];
        }
    } else {
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
            [self setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        }
    }
}


//隐藏系统自带的UI，可以自定义UI
- (void)configureCustomUIOnImagePicker{
    self.showsCameraControls = NO;
    
    UIView *cameraOverlay = [[UIView alloc] init];
    self.cameraOverlayView = cameraOverlay;
}


#pragma mark -UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    //将录制完的视频保存到相册
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    NSURL *sourceURL= [info objectForKey:UIImagePickerControllerMediaURL];
//    NSLog(@"视频时长%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
//    NSLog(@"视频大小%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
//    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:sourceURL]) {
//        [library writeVideoAtPathToSavedPhotosAlbum:sourceURL completionBlock:^(NSURL *assetURL, NSError *error) {
//            
//            //保存成功之后，压缩并且存到沙盒
//            
//            if (self.handleVideoPath) {
//                self.handleVideoPath([self saveVideo:sourceURL]);
//            }
//            
//        }];
//    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    
//    
//    NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
//    NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
//    NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
//    
//    
//    NSURL *newVideoUrl ; //一般.mp4
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
//    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
//    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
//    
//    
//    
//}

//-(NSString *)saveVideo:(NSURL *)url{
//    NSString *fileName = [NSString stringWithFormat:CACHE_KEY_FOR_OfflineVideo];
//    if (![FileUtil isFileExisted:fileName Domains:NSLibraryDirectory]) {
//        [FileUtil createDirectoryAtPath:fileName Domains:NSLibraryDirectory];
//    }
//    NSData *data =[NSData dataWithContentsOfURL:url];
//    NSString *videoPath = [NSString stringWithFormat:@"%@/%@.mp4",[FileUtil getFilePath:fileName Domains:NSLibraryDirectory],[CommonTools uuid]];
//    [data writeToFile:videoPath atomically:YES];
//    return videoPath;
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 视频压缩, 根据原视频的大小不同, 进行不同强度的压缩
- (void)compressionVideoWithURL:(NSURL *)url {
//    @weakify(self)
    // 调用压缩类, 进行压缩
//    [AKAlertViewFactory showLoadingViewWithMessage:@"视频压缩中..."];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [JFCompressionVideo compressedVideoOtherMethodWithURL:url compressionType:AVAssetExportPresetMediumQuality compressionResultPath:^(NSString *resultPath, float memorySize) {
//            @strongify(self)
//            [AKAlertViewFactory dismissLoadingView];
//            NSData *videoData = [NSData dataWithContentsOfFile:resultPath];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [AKAlertViewFactory dismissLoadingView];
//                if (self.handleVideoPath) {
//                    self.handleVideoPath(resultPath);
//                }
//            });
//        }];
    });
}


//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getFileSize:(NSString *)path{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

//此方法可以获取视频文件的时长。
- (CGFloat) getVideoLength:(NSURL *)URL{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


