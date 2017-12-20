//
//  ComNavigationController.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "ComNavigationController.h"

@implementation ComNavigationController

-(void)viewDidLoad{
    [super viewDidLoad];
}


#pragma mark -可以在这个方法里面拦截所有push进来的控制器,进行修改
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.childViewControllers.count>0){
        //不是首界面，push进去的界面都会隐藏tabbar
        viewController.hidesBottomBarWhenPushed=YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem.而且为了隐藏后面子界面的tabbar
    [super pushViewController:viewController animated:animated];
}

@end


