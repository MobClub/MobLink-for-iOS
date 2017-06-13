//
//  MLDInviteViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDInviteViewController.h"

@interface MLDInviteViewController ()

@property (weak, nonatomic) UILabel *topL;
@property (weak, nonatomic) UIButton *shareBtn;
@property (assign, nonatomic) NSInteger num;

@end

@implementation MLDInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"邀请用户";
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"userId"])
    {
        self.num = [[NSUserDefaults standardUserDefaults] integerForKey:@"userId"];
    }
    else
    {
        uint32_t num = 100000 + arc4random_uniform(900000);
        self.num = num;
        [[NSUserDefaults standardUserDefaults] setInteger:num forKey:@"userId"];
    }
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MOBFColor colorWithRGB:0x0077FC] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    
    [self setupUI];
}

- (void)setupUI
{
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollV.contentSize = CGSizeMake(SCREEN_WIDTH, 667 - 108);
    
    UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    topV.backgroundColor = [MOBFColor colorWithRGB:0xFFF7DD];
    
    UILabel *topL = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 100, 40)];
    self.topL = topL;
    NSString *text = [NSString stringWithFormat:@"你的ID是%lu，邀请用户各得10元优惠券", (unsigned long)self.num];
    NSRange idRange = [text rangeOfString:[NSString stringWithFormat:@"%ld",(long)self.num]];
    NSMutableAttributedString *mAttrIdStr = [[NSMutableAttributedString alloc] initWithString:text];
    [mAttrIdStr addAttribute:NSForegroundColorAttributeName value:[MOBFColor colorWithRGB:0x4B89EA] range:idRange];
    topL.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    topL.textAlignment = NSTextAlignmentLeft;
    topL.font = [UIFont systemFontOfSize:13];
    topL.attributedText = mAttrIdStr;
    
    [topV addSubview:topL];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(SCREEN_WIDTH - 65, 8.5, 49, 23);
    [topBtn setTitle:@"换一个ID" forState:UIControlStateNormal];
    [topBtn setTitleColor:[MOBFColor colorWithRGB:0x4E8BED] forState:UIControlStateNormal];
    topBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    topBtn.layer.borderWidth = 0.5;
    topBtn.layer.borderColor = [MOBFColor colorWithRGB:0x4E8BED].CGColor;
    [topBtn addTarget:self action:@selector(changeId) forControlEvents:UIControlEventTouchUpInside];
    
    [topV addSubview:topBtn];
    
    [scrollV addSubview:topV];
    
    UIImage *logo = [UIImage imageNamed:@"logo"];
    UIImageView *logoImageV = [[UIImageView alloc] initWithImage:logo];
    logoImageV.center = CGPointMake(self.view.center.x, CGRectGetMaxY(topV.frame) + logo.size.height / 2.0 + 30);
    [logoImageV sizeToFit];
    
    [scrollV addSubview:logoImageV];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoImageV.frame) + 43, SCREEN_WIDTH, 20)];
    titleLabel.text = @"呼朋唤友 拿红包";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [scrollV addSubview:titleLabel];
    
    NSString *content = @"邀请好友注册，双方各奖励10元红包。";
    NSRange firstRange = [content rangeOfString:@"10元"];
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:content];
    [mAttrStr addAttribute:NSForegroundColorAttributeName value:[MOBFColor colorWithRGB:0x4B89EA] range:firstRange];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + 39, SCREEN_WIDTH - 30, 20)];
    contentLabel.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.attributedText = mAttrStr;
    
    [scrollV addSubview:contentLabel];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareBtn = shareBtn;
    shareBtn.frame = CGRectMake(15, CGRectGetMaxY(contentLabel.frame) + 60, SCREEN_WIDTH - 30, 40);
    shareBtn.backgroundColor = [MOBFColor colorWithRGB:0x4B89EA];
    [shareBtn setTitle:@"快速分享给好友" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 5.0;
    shareBtn.layer.masksToBounds = YES;
    [shareBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollV addSubview:shareBtn];
    
    [self.view addSubview:scrollV];
}

- (void)changeId
{
    uint32_t num = 100000 + arc4random_uniform(900000);
    self.num = num;
    [[NSUserDefaults standardUserDefaults] setInteger:self.num forKey:@"userId"];
    NSString *str = [NSString stringWithFormat:@"你的ID是%d，邀请用户各奖励10元红包", num];
    NSRange idRange = [str rangeOfString:[NSString stringWithFormat:@"%ld",(long)self.num]];
    NSMutableAttributedString *mAttrIdStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mAttrIdStr addAttribute:NSForegroundColorAttributeName value:[MOBFColor colorWithRGB:0x4B89EA] range:idRange];
    self.topL.attributedText = mAttrIdStr;
}

- (void)shareItemClick:(UIButton *)shareBtn
{
    //先获取mobid成功后分享
    NSString *inviteID = [NSString stringWithFormat:@"%lu", (unsigned long)self.num];
    NSDictionary *params = @{
                             @"inviteID" : inviteID
                             };
    // 先读取缓存的mobid,缓存没有再进行网络请求
    NSString *keyPath = [NSString stringWithFormat:@"/params/invite/%@", inviteID];
    NSString *cacheMobid = [[MLDTool shareInstance] mobidForKeyPath:keyPath];
    NSString *title = @"邀请你注册得10元红包";
    NSString *text = @"这是一个MobLink功能演示";
    NSString *image = @"hongbao_wxtj.png";
    if (cacheMobid)
    {
        [[MLDTool shareInstance] shareWithMobId:cacheMobid
                                          title:title
                                           text:text
                                          image:image
                                           path:@"/params/invite"
                                         onView:shareBtn];
    }
    else
    {
        [[MLDTool shareInstance] getMobidWithPath:@"/params/invite"
                                           source:@"MobLinkDemo-Invite"
                                           params:params
                                           result:^(NSString *mobid) {
                                                 // 先缓存mobid,如果有的话
                                                 if (mobid)
                                                 {
                                                     [[MLDTool shareInstance] cacheMobid:mobid forKeyPath:keyPath];
                                                 }
                                                 
                                                 [[MLDTool shareInstance] shareWithMobId:mobid
                                                                                   title:title
                                                                                    text:text
                                                                                   image:image
                                                                                    path:@"/params/invite"
                                                                                  onView:shareBtn];
                                             }];
    }
}

- (void)shareBtnClick
{
    NSLog(@"%s", __func__);
}

@end
