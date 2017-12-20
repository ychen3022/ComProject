//
//  ComGifView.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComGifView.h"
#import <ImageIO/ImageIO.h>

@interface ComGifView ()
{
    CGImageSourceRef gifSource; // 保存gif动画的所有内容
    NSDictionary *gifProperties;  // 保存gif动画属性
    size_t index;// gif动画播放开始的帧序号
    size_t count;// gif动画的总帧数
    NSTimer *timer;// 播放gif动画所使用的timer
}
@end



@implementation ComGifView

#pragma mark -根据filePath初始化gifView
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)filePath{
    
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gifSource = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:filePath], (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gifSource);
    }
    return self;
}



#pragma mark -根据data初始化gifView
- (id)initWithFrame:(CGRect)frame data:(NSData *)data{
    self = [super initWithFrame:frame];
    if (self) {
        
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gifSource = CGImageSourceCreateWithData((CFDataRef)data, (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gifSource);
    }
    return self;
}


#pragma mark -播放gif动画
-(void)play{
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gifSource, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}


#pragma mark -开始播放gif动画
- (void)startGif{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [timer fire];
}

#pragma mark -停止播放gif动画
- (void)stopGif{
    [timer invalidate];
    timer = nil;
}


-(void)removeFromSuperview{
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}


- (void)dealloc {
    CFRelease(gifSource);
}
@end


