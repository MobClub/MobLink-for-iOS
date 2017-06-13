//
//  MLDParamsViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDParamsViewController.h"
#import "CustomButton.h"
#import "MLDTicketViewController.h"
#import "MLDInviteViewController.h"

@interface MLDParamsViewController ()

@end

@implementation MLDParamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [MOBFColor colorWithRGB:0xF7F9FA];
    
    [self setupUI];
}

- (void)setupUI
{
    CustomButton *fjpBtn = [[CustomButton alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, (self.view.frame.size.height - 118) / 2.0)];
    fjpBtn.tag = 3001;
    [fjpBtn setTitle:@"飞机票App" forState:UIControlStateNormal];
    [fjpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fjpBtn setImage:[UIImage imageNamed:@"fjp"] forState:UIControlStateNormal];
    fjpBtn.backgroundColor = [UIColor whiteColor];
    fjpBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [fjpBtn addTarget:self action:@selector(push2Next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fjpBtn];
    
    CustomButton *yqBtn = [[CustomButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fjpBtn.frame) + 10, SCREEN_WIDTH, (self.view.frame.size.height - 118) / 2.0)];
    yqBtn.tag = 3002;
    [yqBtn setTitle:@"邀请用户发奖励场景" forState:UIControlStateNormal];
    [yqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yqBtn setImage:[UIImage imageNamed:@"yq"] forState:UIControlStateNormal];
    yqBtn.backgroundColor = [UIColor whiteColor];
    yqBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [yqBtn addTarget:self action:@selector(push2Next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yqBtn];
}

- (void)push2Next:(CustomButton *)sender
{
    switch (sender.tag)
    {
        case 3001:
        {
            MLDTicketViewController *ticketCtr = [[MLDTicketViewController alloc] init];
            ticketCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ticketCtr animated:YES];
            break;
        }
        case 3002:
        {
            MLDInviteViewController *inviteCtr = [[MLDInviteViewController alloc] init];
            inviteCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:inviteCtr animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
