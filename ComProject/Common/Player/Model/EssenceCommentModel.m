//
//  EssenceCommentModel.m
//  项目模板
//
//  Created by ychen on 16/10/8.
//  Copyright © 2016年 ComProject. All rights reserved.
//

#import "EssenceCommentModel.h"
#import "NSDate+Ext.h"
#import "NSString+Ext.h"

@implementation EssenceCommentModel

#pragma mark -评论时间
-(NSString *)ctime{
    //日期格式化类
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    //设置日期格式（y:年  M:月  d:日  H:时  m:分  s:秒）
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create=[formatter dateFromString:_ctime];
    
    if ([create isThisYear]) {//是今年
        if ([create isToday]) {//今天
            NSDateComponents *cmps=[[NSDate date] compareFrom:create];
            if (cmps.hour>=1) {//时间差距>=1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute>=1){//时间差距>=1分钟
                return [NSString stringWithFormat:@"%zd分钟",cmps.minute];
            }else{//时间差距<1小时
                return @"刚刚";
            }
        }else if ( [create isYestorday]){//昨天
            formatter.dateFormat=@"昨天 HH:mm:ss";
            return [formatter stringFromDate:create];
        }else{//其他情况
            formatter.dateFormat=@"MM-dd HH:mm:ss";
            return [formatter stringFromDate:create];
        }
    }else{//不是今年
        return _ctime;
    }
}



#pragma mark -评论cell中评论内容的高度
-(CGFloat)contentLabelH{
    return [_content calculateTextHeightWithFont:[UIFont systemFontOfSize:14] maxW:KScreenW-3*10-40].height;
}


#pragma mark -评论cell的高度
-(CGFloat)commentCellH{
    return  40+10+[_content calculateTextHeightWithFont:[UIFont systemFontOfSize:14] maxW:KScreenW-3*10-40].height;
}
@end
