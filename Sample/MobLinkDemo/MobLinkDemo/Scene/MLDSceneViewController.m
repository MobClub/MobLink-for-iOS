//
//  MLDSceneViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDSceneViewController.h"
#import "CustomButton.h"
#import "MLDNewsTableViewController.h"
#import "MLDShoppingCollectionViewController.h"
#import "MLDVideoCollectionViewController.h"

@interface MLDSceneViewController ()

@end

@implementation MLDSceneViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [MOBFColor colorWithRGB:0xF7F9FA];
    
    [self setupUI];
}


- (void)setupUI
{
    CustomButton *zxBtn = [[CustomButton alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, (self.view.frame.size.height - 128) / 3.0)];
    zxBtn.tag = 2001;
    [zxBtn setTitle:@"资讯App" forState:UIControlStateNormal];
    [zxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zxBtn setImage:[UIImage imageNamed:@"zx"] forState:UIControlStateNormal];
    zxBtn.backgroundColor = [UIColor whiteColor];
    zxBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [zxBtn addTarget:self action:@selector(push2Next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zxBtn];
    
    CustomButton *spBtn = [[CustomButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(zxBtn.frame) + 10, SCREEN_WIDTH, (self.view.frame.size.height - 128) / 3.0)];
    spBtn.tag = 2002;
    [spBtn setTitle:@"视频App" forState:UIControlStateNormal];
    [spBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [spBtn setImage:[UIImage imageNamed:@"sp"] forState:UIControlStateNormal];
    spBtn.backgroundColor = [UIColor whiteColor];
    spBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [spBtn addTarget:self action:@selector(push2Next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spBtn];
    
    CustomButton *dsBtn = [[CustomButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(spBtn.frame) + 10, SCREEN_WIDTH, (self.view.frame.size.height - 128) / 3.0)];
    dsBtn.tag = 2003;
    [dsBtn setTitle:@"电商App" forState:UIControlStateNormal];
    [dsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dsBtn setImage:[UIImage imageNamed:@"ds"] forState:UIControlStateNormal];
    dsBtn.backgroundColor = [UIColor whiteColor];
    dsBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [dsBtn addTarget:self action:@selector(push2Next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dsBtn];
}


- (void)push2Next:(CustomButton *)sender
{
    switch (sender.tag)
    {
        case 2001:
        {
            MLDNewsTableViewController *newsCtr = [[MLDNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
            newsCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newsCtr animated:YES];
            break;
        }
        case 2002:
        {
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            MLDVideoCollectionViewController *videoCtr = [[MLDVideoCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
            videoCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:videoCtr animated:YES];
            break;
        }
        case 2003:
        {
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            MLDShoppingCollectionViewController *shoppingCtr = [[MLDShoppingCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
            shoppingCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shoppingCtr animated:YES];
            break;
        }
        
        default:
            break;
    }
}

@end
