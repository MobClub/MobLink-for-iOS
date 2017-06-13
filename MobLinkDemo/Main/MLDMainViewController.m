//
//  MLDMainViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDMainViewController.h"

#import "MLDDemoViewController.h"
#import "MLDSceneViewController.h"
#import "MLDParamsViewController.h"

@interface MLDMainViewController ()

@end

@implementation MLDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
}

/**
 添加所有子控制器
 */
- (void)addChildViewControllers
{
    // 演示
    MLDDemoViewController *demoCtr = [[MLDDemoViewController alloc] init];
    [self addChildViewController:demoCtr navTitle:@"演示" tabTitle:@"演示" imageName:@"ys"];
    // 场景
    MLDSceneViewController *sceneCtr = [[MLDSceneViewController alloc] init];
    [self addChildViewController:sceneCtr navTitle:@"场景" tabTitle:@"常见应用场景" imageName:@"cjyycj"];
    // 参数
    MLDParamsViewController *paramsCtr = [[MLDParamsViewController alloc] init];
    [self addChildViewController:paramsCtr navTitle:@"场景" tabTitle:@"传入参数场景" imageName:@"crcscj"];
}

/**
 添加一个子控制器

 @param childController 子控制器
 @param navTitle 导航栏标题
 @param tabTitle tabBar标题
 @param imageName tabBar图片名称
 */
- (void)addChildViewController:(UIViewController *)childController
                      navTitle:(NSString *)navTitle
                      tabTitle:(NSString *)tabTitle
                     imageName:(NSString *)imageName
{
    childController.navigationItem.title = navTitle;
    childController.tabBarItem.title = tabTitle;
    
    childController.tabBarItem.image = [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSString *selImgName = [NSString stringWithFormat:@"%@2",imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed: selImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [childController.tabBarItem setTitleTextAttributes:@{
                                                         NSForegroundColorAttributeName : [UIColor blackColor],
                                                         NSFontAttributeName : [UIFont systemFontOfSize:11]
                                                         }
                                              forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{
                                                         NSForegroundColorAttributeName : [MOBFColor colorWithRGB:0x4E8BED],
                                                         NSFontAttributeName : [UIFont systemFontOfSize:11]
                                                         }
                                              forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

@end
