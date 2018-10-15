//
//  MLDInviteSuccessViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDInviteSuccessViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import <MobLink/MLSDKScene.h>
#import <MobLink/UIViewController+MLSDKRestore.h>

@interface MLDInviteSuccessViewController()<MLDBackItemHandlerProtocol>

@property (nonatomic, strong) MLSDKScene *scene;

@property (weak, nonatomic) UILabel *helloLabel;
@property (weak, nonatomic) UILabel *yqrLabel;

@end

@implementation MLDInviteSuccessViewController

+ (NSString *)MLSDKPath
{
    return @"/params/invite";
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
    self.title = @"邀请用户";
    
    [self setupUI];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.scene)
        {
            [[MLDTool shareInstance] showAlertWithScene:self.scene];
        }
    });
}

/**
 拦截导航栏返回按钮代理方法
 
 @return YES 继续Pop  NO 不再Pop
 */
- (BOOL)navigationShouldPopOnBackButtonClick
{
    [self.navigationController.childViewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[MLDInviteSuccessViewController class]])
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
    NSDictionary *params = self.scene.params;
    
    UIImage *about = [UIImage imageNamed:@"about"];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:about];
    imageV.center = CGPointMake(self.view.center.x, 64 + about.size.height / 2.0 + 92 * PUBLICSCALE);
    [imageV sizeToFit];
    
    [self.view addSubview:imageV];
    
    UILabel *helloLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame) + 35 * PUBLICSCALE, SCREEN_WIDTH, 30)];
    self.helloLabel = helloLabel;
    NSString *name = params[@"name"] == nil ? @"" : params[@"name"];
    helloLabel.text = [NSString stringWithFormat:@"你好，%@", name];
    helloLabel.textColor = [UIColor blackColor];
    helloLabel.textAlignment = NSTextAlignmentCenter;
    helloLabel.font = [UIFont systemFontOfSize:24];
    
    [self.view addSubview:helloLabel];
    
    UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(helloLabel.frame) + 15, SCREEN_WIDTH, 30)];
    successLabel.text = @"注册成功";
    successLabel.textColor = [UIColor blackColor];
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.font = [UIFont systemFontOfSize:24];
    
    [self.view addSubview:successLabel];
    
    UILabel *yqrLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 75, SCREEN_WIDTH, 20)];
    self.yqrLabel = yqrLabel;
    NSString *inviteID = params[@"inviteID"] == nil ? @"" : params[@"inviteID"];
    yqrLabel.text = [NSString stringWithFormat:@"邀请人ID:%@", inviteID];
    yqrLabel.textColor = [UIColor blackColor];
    yqrLabel.textAlignment = NSTextAlignmentCenter;
    yqrLabel.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:yqrLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(yqrLabel.frame) + 5, SCREEN_WIDTH, 20)];
    bottomLabel.text = @"双方各奖励10元红包";
    bottomLabel.textColor = [UIColor blackColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:bottomLabel];
}

@end
