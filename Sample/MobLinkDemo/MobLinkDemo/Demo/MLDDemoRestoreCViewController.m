//
//  MLDDemoRestoreCViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDDemoRestoreCViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import <MobLink/MLSDKScene.h>
#import <MobLink/UIViewController+MLSDKRestore.h>

@interface MLDDemoRestoreCViewController()<MLDBackItemHandlerProtocol>

@property (nonatomic, strong) MLSDKScene *scene;

@end

@implementation MLDDemoRestoreCViewController

+ (NSString *)MLSDKPath
{
    return @"/demo/c";
}

- (instancetype)initWithMobLinkScene:(MLSDKScene *)scene
{
    if (self = [super init])
    {
        self.scene = scene;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"C页面";
    
    [self setupUI];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkParams];
    });
}

/**
 拦截导航栏返回按钮代理方法
 
 @return YES 继续Pop  NO 不再Pop
 */
- (BOOL)navigationShouldPopOnBackButtonClick
{
    [self.navigationController.childViewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[MLDDemoRestoreCViewController class]])
        {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }
    }];
    return NO;
}

// 视图将要消失时关闭所有弹窗
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[MLDTool shareInstance] dismissAlert];
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, 150, 150);
    label.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    label.text = @"C";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:150];
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 150, 40);
    button.center = CGPointMake(self.view.center.x, CGRectGetMaxY(label.frame) + 50);
    [button setTitle:@"查看参数" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(checkParams) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:button];
}

- (void)checkParams
{
    if (self.scene)
    {
        [[MLDTool shareInstance] showAlertWithScene:self.scene];
    }
}

@end
