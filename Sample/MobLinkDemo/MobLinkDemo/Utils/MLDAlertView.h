//
//  MLDAlertView.h
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>

// 动画枚举
typedef NS_ENUM(NSInteger , MLDShowAnimationStyle) {
    MLDShowAnimationDefault = 0,
    MLDShowAnimationLeftShake  ,
    MLDShowAnimationTopShake   ,
    MLDShowAnimationNO
};

// 展示内容控件类型枚举
typedef NS_ENUM(NSInteger , MLDShowContentType) {
    MLDShowContentTypeLabel = 0,
    MLDShowContentTypeTextView
};

// 点击的按钮类型枚举
typedef NS_ENUM(NSInteger , MLDButtonType) {
    MLDButtonTypeCancel = 1121,
    MLDButtonTypeSure
};

// 按钮点击block
typedef void(^MLDAlertClickButtonBlock)(MLDButtonType type);

@interface MLDAlertView : UIView

/**
 初始化方法
 
 @param title 提示框标题
 @param message 提示内容
 @param cancelTitle 取消按钮标题
 @param otherBtnTitle 其他按钮标题(目前仅支持2个按钮)
 @param block 按钮点击回调
 @param type 展示内容所用的控件类型
 @return alertView对象
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
               cancelBtnTitle:(NSString *)cancelTitle
                otherBtnTitle:(NSString *)otherBtnTitle
                   clickBlock:(MLDAlertClickButtonBlock)block
                         type:(MLDShowContentType)type;

/**
 显示alertView,使用默认动画
 */
- (void)show;

/**
 动画显示AlertView
 
 @param style 动画方式
 */
- (void)showWithAnimationStyle:(MLDShowAnimationStyle)style;

/**
 关闭alertView
 */
- (void)dismiss;

@end
