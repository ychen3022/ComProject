//
//  MediaModel.h
//  照片视频Demo
//
//  Created by 陈园 on 2017/7/11.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 MediaModel类型
 */
typedef NS_ENUM(NSInteger, MediaType) {
    MediaType_Photo=0,//照片
    MediaType_Video=1,//视频
};

/**
 MediaCell展示样式
 */
typedef NS_ENUM(NSInteger, MediaCellState) {
    MediaCellState_Normal=0,//展示正常样式
    MediaCellState_Add=1,//展示+号
};



@interface MediaModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id asset;//相片资源
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) UIImage *coverPhoto;

@property (nonatomic, assign) MediaType mediaType;
@property (nonatomic, assign) MediaCellState mediaCellState;
@end



//照片model
@interface photoModel : MediaModel

@end



//视频model
@interface videoModel : MediaModel

@end



