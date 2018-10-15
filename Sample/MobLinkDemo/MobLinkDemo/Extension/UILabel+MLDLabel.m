//
//  UILabel+MLDLabel.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "UILabel+MLDLabel.h"

@implementation UILabel (MLDLabel)

/**
 根据指定宽度内容和字体获取Label的实际高度
 
 @param width 指定宽度
 @param title 内容
 @param font 字体
 @return 高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

/**
 根据内容和字体获取Label的实际宽度
 
 @param title 内容
 @param font 字体
 @return 宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
