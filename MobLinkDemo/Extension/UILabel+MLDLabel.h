//
//  UILabel+MLDLabel.h
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MLDLabel)

/**
 根据指定宽度内容和字体获取Label的实际高度
 
 @param width 指定宽度
 @param title 内容
 @param font 字体
 @return 高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width
                      title:(NSString *)title
                       font:(UIFont*)font;

/**
 根据内容和字体获取Label的实际宽度
 
 @param title 内容
 @param font 字体
 @return 宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
