//
//  ComGraphicsView.h
//  ComProject
//
//  Created by 陈园 on 2017/11/2.
//  Copyright © 2017年 陈园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComGraphicsView : UIView
@property (nonatomic, strong) UIImageView *imageView;
- (UIImage *)addImageWithLogoText:(UIImage *)img text:(NSString *)text1;
@end
