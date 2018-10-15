//
//  MLDShareView.h
//  MobLinkDemo
//
//  Created by lujh on 2018/6/19.
//  Copyright © 2018年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLDShareView : UIView

#pragma mark - 需要传入的名称数组
/**
 显示名称的数组
 */
@property (nonatomic, strong) NSArray<NSString *> *itemNameArray;

#pragma mark - 颜色

/**
 按钮背景颜色
 */
@property (nonatomic, strong) UIColor *shareBtnColor;

/**
 显示名称颜色
 */
@property (nonatomic, strong) UIColor *itemTextColor;

/**
 取消按钮背景颜色
 */
@property (nonatomic, strong) UIColor *cancelBtnBgColor;

/**
 取消按钮颜色
 */
@property (nonatomic, strong) UIColor *cancelTitleColor;


#pragma mark - 字体大小

/**
 显示名称字体
 */
@property (nonatomic, assign) UIFont *itemFont;

#pragma mark - Actions

/**
 加载分享页面并得到点击事件的回调
 
 @param itemNameArray  显示名称的数组
 @param handler index 从0开始,
 */
- (void)loadShareViewWithItemNameArray:(NSArray *)itemNameArray
                          ClickHandler:(void(^)(NSInteger index))handler;

/**
 弹出分享页面
 */
- (void)showShareView;


/**
 取消分享页面
 */
- (void)dismissShareView;


@end
