//
//  PopListTableViewController.h
//  TestDemo
//
//  Created by youzu on 2017/1/9.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopListTableViewController : UITableViewController

/**
 是否展开菜单
 */
@property (nonatomic, assign)BOOL isOpen;

/**
 数据源
 */
@property (nonatomic, strong) NSArray<NSString *> * listSource;

/**
 字体颜色
 */
@property (strong, nonatomic) UIColor *titleColor;

/**
 选中某一行回调
 */
@property (copy, nonatomic) void (^selectedBlock)(NSInteger index);

@end
