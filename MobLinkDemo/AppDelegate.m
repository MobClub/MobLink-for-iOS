//
//  AppDelegate.m
//  MobLinkDemo
//
//  Created by youzu on 2017/1/11.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "AppDelegate.h"

#import "MLDMainViewController.h"

#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDK/ShareSDK.h>
#import <MobLink/MobLink.h>
#import <MobLink/MLSDKScene.h>
#import <MobLink/IMLSDKRestoreDelegate.h>

@interface AppDelegate () <IMLSDKRestoreDelegate>

@property (strong, nonatomic) UITabBarController *tabBarCtr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MLDMainViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // 初始化MobLink 线上:1b8898cb51ccb
    [MobLink registerApp:@"1b8898cb51ccb"];
    
    // 设置MobLink代理
    [MobLink setDelegate:self];
    
    // 设置返回按钮样式
    [self setNavBackItem];
    
    // 初始化ShareSDK
    [self initShareSDK];
    
    return YES;
}

- (void)setNavBackItem
{
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    
    //设置返回样式图片
    UIImage *image = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navigationBar.backIndicatorImage = image;
    
    navigationBar.backIndicatorTransitionMaskImage = image;
    
    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    
    UIOffset offset;
    
    offset.horizontal = - 800;
    
    offset.vertical =  - 500;
    
    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    
}

/**
 初始化ShareSDK
 */
- (void)initShareSDK
{
    [ShareSDK registerApp:@"1b8f1341a7d00"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                             
                         default:
                             break;
                     }
                     
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wx01634d672597c03c"
                                                   appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                             break;
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1105479028"
                                                  appKey:@"HxHozohsRAkSGREY"
                                                authType:SSDKAuthTypeSSO];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"474962333"
                                                       appSecret:@"26522c6ed236057fd4ff5005449f98e9"
                                                     redirectUri:@"http://www.sharesdk.cn"
                                                        authType:SSDKAuthTypeBoth];
                             break;
                             
                         default:
                             break;
                     }
                     
                 }];
}


- (void)IMLSDKStartCheckScene
{
    NSLog(@"Start Check Scene");
}

- (void)IMLSDKEndCheckScene
{
    NSLog(@"End Check Scene");
}

- (void) IMLSDKWillRestoreScene:(MLSDKScene *)scene Restore:(void (^)(BOOL, RestoreStyle))restoreHandler
{
    NSLog(@"Will Restore Scene - Path:%@",scene.path);
    
    if ([scene.path hasSuffix:@"shopping"])
    {
        [[MLDTool shareInstance] showAlertWithTitle:nil
                                            message:@"是否进行场景恢复？"
                                        cancelTitle:@"否"
                                         otherTitle:@"是"
                                         clickBlock:^(MLDButtonType type) {
                                             type == MLDButtonTypeSure ? restoreHandler(YES, Default) : restoreHandler (NO, Default);
                                         }];
    }
    else
    {
        restoreHandler(YES, Default);
    }
    
}

- (void)IMLSDKCompleteRestore:(MLSDKScene *)scene
{
    NSLog(@"Complete Restore -Path:%@",scene.path);
}

- (void)IMLSDKNotFoundScene:(MLSDKScene *)scene
{
    NSLog(@"Not Found Scene - Path :%@",scene.path);
    
    [[MLDTool shareInstance] showAlertWithTitle:@"没有找到路径"
                                        message:[NSString stringWithFormat:@"Path: %@",scene.path]
                                    cancelTitle:@"OK"
                                     otherTitle:nil
                                     clickBlock:nil];
}

@end
