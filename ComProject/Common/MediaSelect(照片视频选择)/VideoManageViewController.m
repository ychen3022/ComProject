//
//  VideoManageViewController.m
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "VideoManageViewController.h"
#import "MediaManageView.h"
#import "MediaImagePickerController.h"
#import "TZImagePickerController.h"



@interface VideoManageViewController ()<MediaManageViewDelegate,TZImagePickerControllerDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) MediaManageView *mediaManageView;
@property (nonatomic, strong) NSMutableArray *videoArr;
@end

@implementation VideoManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"视频选择";
    [self creatSubView];
}

-(void)creatSubView{
    self.mediaManageView=[[MediaManageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.mediaManageView.delegate=self;
    self.mediaManageView.maxCount=10;
    self.mediaManageView.mediaManageType=MediaManageType_Edit;
    self.mediaManageView.dataArr=self.videoArr;
    [self.view addSubview:self.mediaManageView];
}


#pragma mark - mediaManageViewDelegate
-(void)mediaManageView:(MediaManageView *)mediaManageView didAddCell:(MediaCollectionViewCell *)cell{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"标题" message:@"请拍摄照片或者从相册选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takeVideo];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectVideo];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)selectVideo{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVC.allowPickingVideo = YES; //是否允许选择视频
    imagePickerVC.allowPickingImage = NO; //是否允许选择照片
    imagePickerVC.allowPickingOriginalPhoto = YES; //是否允许选择原图;
    imagePickerVC.allowPickingGif = NO; //是否允许选择gif
    //通过block的方法来得到用户选择的照片，还可以使用代理
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark -TZImagePickerController选择视频代理(只能单选)
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    MediaModel *selectModel=[[MediaModel alloc] init];
    selectModel.coverPhoto=coverImage;
    selectModel.asset=asset;
    selectModel.mediaType=MediaType_Video;
    selectModel.mediaCellState=MediaCellState_Normal;
    [self.videoArr addObject:selectModel];
    [self.mediaManageView reloadData];
}


-(void)takeVideo{
    
    
}




- (NSString *)creatSandBoxFilePathIfNoExist{
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
   
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];// 用时间, 给文件重新命名, 防止视频存储覆盖,
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    //创建目录
    NSString *createPath = [NSString stringWithFormat:@"%@/Video", pathDocuments];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileImage is exists.");
    }
    NSString *resultPath = [createPath stringByAppendingPathComponent:[NSString stringWithFormat:@"outputJFVideo-%@.mov", [formater stringFromDate:[NSDate date]]]];
    NSLog(@"%@",resultPath);
    return resultPath;
}


- (NSMutableArray *)videoArr {
    if (!_videoArr) {
        self.videoArr = [[NSMutableArray alloc] init];
    }
    return _videoArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
