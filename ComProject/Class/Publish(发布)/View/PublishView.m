//
//  PublishView.m
//  ComProject
//
//  Created by 陈园 on 2017/12/12.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import "PublishView.h"
#import "PublishViewButton.h"
#import "PublishTopicViewController.h"


static CGFloat const XMGAnimationDelay = 0.2;
static CGFloat const XMGSpringFactor = 10;

@implementation PublishView
static UIWindow *window;
+(void)show{
    window=[[UIWindow alloc] init];
    window.frame=[UIScreen mainScreen].bounds;
    window.backgroundColor=[UIColor whiteColor];
    window.hidden=NO;
    
    //添加发布界面
    PublishView *publishView=[PublishView publishView];
    publishView.frame=[UIScreen mainScreen].bounds;
    [window addSubview:publishView];
}

+(instancetype)publishView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    //添加标语
    UIImageView *sloganView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.top=KScreenH*0.2;
    sloganView.centerX=KScreenW*0.5;
    [self addSubview:sloganView];
    
    //照片数据
    NSArray *imageArr=@[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titleArr= @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCol=3;
    CGFloat btnW=72;
    CGFloat btnH=72+30;
    CGFloat marginX=(KScreenW -btnW*maxCol)/(maxCol +1);
    CGFloat marginY=CGRectGetMaxY(sloganView.frame)+50;
    CGFloat marginW=marginX;
    CGFloat marginH=20;
    for (int index=0; index<imageArr.count; index++) {
        PublishViewButton *btn=[[PublishViewButton alloc] init];
        btn.tag=index;
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[index]]] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",titleArr[index]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        // 按钮弹跳动画
        int row = index / maxCol;
        int col = index % maxCol;
        CGFloat btnX=marginX+col*(marginW +btnW);
        CGFloat btnYEnd=marginY+(marginH+btnH)*row;
        CGFloat btnYBegin=btnYEnd -KScreenH;
        
        POPSpringAnimation *animation=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue=[NSValue valueWithCGRect:CGRectMake(btnX, btnYBegin, btnW, btnH)];
        animation.toValue=[NSValue valueWithCGRect:CGRectMake(btnX, btnYEnd, btnW, btnH)];
        animation.springBounciness=XMGSpringFactor;
        animation.beginTime=CACurrentMediaTime()+XMGAnimationDelay*index;
        [btn pop_addAnimation:animation forKey:nil];
    }
}

-(void)btnAction:(PublishViewButton *)button{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            DLog(@"发视频");
        } else if (button.tag == 1) {
            DLog(@"发图片");
        }else if (button.tag==2){
            DLog(@"发段子");
            PublishTopicViewController *publishTopicVC=[[[NSBundle mainBundle] loadNibNamed:@"PublishTopicViewController" owner:self options:nil] lastObject];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishTopicVC animated:YES completion:nil];
        }else if (button.tag==3){
            DLog(@"发声音");
        }else if (button.tag==4){
            DLog(@"审帖");
        }else if (button.tag==5){
            DLog(@"离线下载");
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletionBlock:nil];
}



#pragma mark -取消视图
- (IBAction)cancelBtnAction:(id)sender {
    [self cancelWithCompletionBlock:nil];
}



/**
 *  取消视图的block方法
 *
 *  @param completionBlock
 */
-(void)cancelWithCompletionBlock:(void (^)())completionBlock{
    int beginIndex=1;
    for (int i=beginIndex; i<self.subviews.count; i++) {
        UIView *subView=self.subviews[i];
        //基本动画
        POPBasicAnimation *animation=[POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY=subView.centerY+KScreenH;
        animation.toValue=[NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        animation.beginTime = CACurrentMediaTime() + (i - beginIndex) * XMGAnimationDelay;
        [subView pop_addAnimation:animation forKey:nil];
        
        //监听最后一个动画
        if(i==self.subviews.count-1){
            [animation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                // 销毁窗口
                window.hidden=YES;
                window = nil;
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}
@end
