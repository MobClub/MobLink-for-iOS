//
//  MLDMiniViewController.m
//  MobLinkDemo
//
//  Created by Sands_Lee on 2018/3/22.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "MLDMiniViewController.h"
#import "RightImageButton.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface MLDMiniViewController ()<UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) UITextField *pathTextField;
@property (weak, nonatomic) UITextField *sourceTextField;
@property (weak, nonatomic) UITextField *firstKey;
@property (weak, nonatomic) UITextField *firstValue;
@property (weak, nonatomic) UITextField *secondKey;
@property (weak, nonatomic) UITextField *secondValue;
@property (weak, nonatomic) UITextField *thirdKey;
@property (weak, nonatomic) UITextField *thirdValue;

@property (weak, nonatomic) UIButton *mobidBtn;
@property (weak, nonatomic) UIButton *shareBtn;

@property (copy, nonatomic) NSString *path;
@property (copy, nonatomic) NSString *mobId;

@end

@implementation MLDMiniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.path = @"/demo/mini";
    UIBarButtonItem *fillDefault = [[UIBarButtonItem alloc] initWithTitle:@"填充默认值" style:UIBarButtonItemStylePlain target:self action:@selector(fillDefault)];
    self.navigationItem.rightBarButtonItem = fillDefault;
    
    [self setupUI];
}

/**
 填充默认值
 */
- (void)fillDefault
{
    self.sourceTextField.text = @"MobLinkMini";
    self.firstKey.text = @"key1";
    self.firstValue.text = @"value1";
    self.secondKey.text = @"key2";
    self.secondValue.text = @"value2";
    self.thirdKey.text = @"key3";
    self.thirdValue.text = @"value3";
}

#pragma mark - UI界面

/**
 初始化UI
 */
- (void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    
    CGFloat publicX = (SCREEN_WIDTH - 345 * PUBLICSCALE) / 2.0;
    // 路径Label
    UILabel *pathLabel = [self labelWithText:@"路径path"];
    pathLabel.frame = CGRectMake(publicX, 25, 200, 30);
    [scrollView addSubview:pathLabel];
    
    // 路径textField
    UITextField *pathTextField = [self textFieldWithPlaceholder:@"/demo/mini"];
    self.pathTextField = pathTextField;
    pathTextField.frame = CGRectMake(publicX, CGRectGetMaxY(pathLabel.frame) + 10, 345 * PUBLICSCALE, 40);
    pathTextField.enabled = NO;
    [scrollView addSubview:pathTextField];
    
    // 来源Label
    UILabel *sourceLabel = [self labelWithText:@"来源source"];
    sourceLabel.frame = CGRectMake(publicX, CGRectGetMaxY(pathTextField.frame) + 25, 200, 30);
    [scrollView addSubview:sourceLabel];
    
    // 来源textField
    UITextField *sourceTextField = [self textFieldWithPlaceholder:@"用于记录来源，例如 uuid-123456"];
    self.sourceTextField = sourceTextField;
    sourceTextField.frame = CGRectMake(publicX, CGRectGetMaxY(sourceLabel.frame) + 10, 345 * PUBLICSCALE, 40);
    [scrollView addSubview:sourceTextField];
    
    // 自定义参数Label
    UILabel *paramsLabel = [self labelWithText:@"自定义参数"];
    paramsLabel.frame = CGRectMake(publicX, CGRectGetMaxY(sourceTextField.frame) + 25, 200, 30);
    [scrollView addSubview:paramsLabel];
    
    // 第一个自定义参数
    UITextField *firstKey = [self textFieldWithPlaceholder:@"键Key"];
    self.firstKey = firstKey;
    firstKey.frame = CGRectMake(publicX, CGRectGetMaxY(paramsLabel.frame) + 10, 150 * PUBLICSCALE, 40);
    [scrollView addSubview:firstKey];
    
    UITextField *firstValue = [self textFieldWithPlaceholder:@"值value"];
    self.firstValue = firstValue;
    firstValue.frame = CGRectMake(CGRectGetMaxX(firstKey.frame) + 10, CGRectGetMaxY(paramsLabel.frame) + 10, 185 * PUBLICSCALE, 40);
    [scrollView addSubview:firstValue];
    
    // 第二个自定义参数
    UITextField *secondKey = [self textFieldWithPlaceholder:@"键Key"];
    self.secondKey = secondKey;
    secondKey.frame = CGRectMake(publicX, CGRectGetMaxY(firstKey.frame) + 10, 150 * PUBLICSCALE, 40);
    [scrollView addSubview:secondKey];
    
    UITextField *secondValue = [self textFieldWithPlaceholder:@"值value"];
    self.secondValue = secondValue;
    secondValue.frame = CGRectMake(CGRectGetMaxX(secondKey.frame) + 10, CGRectGetMaxY(firstValue.frame) + 10, 185 * PUBLICSCALE, 40);
    [scrollView addSubview:secondValue];
    
    // 第三个自定义参数
    UITextField *thirdKey = [self textFieldWithPlaceholder:@"键Key"];
    self.thirdKey = thirdKey;
    thirdKey.frame = CGRectMake(publicX, CGRectGetMaxY(secondKey.frame) + 10, 150 * PUBLICSCALE, 40);
    [scrollView addSubview:thirdKey];
    
    UITextField *thirdValue = [self textFieldWithPlaceholder:@"值value"];
    self.thirdValue = thirdValue;
    thirdValue.frame = CGRectMake(CGRectGetMaxX(thirdKey.frame) + 10, CGRectGetMaxY(secondValue.frame) + 10, 185 * PUBLICSCALE, 40);
    [scrollView addSubview:thirdValue];
    
    // 获取Mobid
    UIButton *mobidBtn = [[UIButton alloc] initWithFrame:CGRectMake(publicX, CGRectGetMaxY(thirdValue.frame) + 45, 345 * PUBLICSCALE, 40)];
    self.mobidBtn = mobidBtn;
    [mobidBtn setTitle:@"获取Mobid" forState:UIControlStateNormal];
    [mobidBtn setTitleColor:[MOBFColor colorWithRGB:0x4B89EA] forState:UIControlStateNormal];
    mobidBtn.layer.cornerRadius = 5.0;
    mobidBtn.layer.masksToBounds = YES;
    mobidBtn.layer.borderWidth = 1.0;
    mobidBtn.layer.borderColor = [MOBFColor colorWithRGB:0x4B89EA].CGColor;
    [mobidBtn addTarget:self action:@selector(getMobid) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:mobidBtn];
    
    // Share
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(publicX, CGRectGetMaxY(mobidBtn.frame) + 20, 345 * PUBLICSCALE, 40)];
    self.shareBtn = shareBtn;
    shareBtn.backgroundColor = [UIColor whiteColor];
    [shareBtn setTitle:@"分享至微信小程序" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[MOBFColor colorWithRGB:0xd9d9d9] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 5.0;
    shareBtn.layer.masksToBounds = YES;
    shareBtn.layer.borderWidth = 1.0;
    shareBtn.layer.borderColor = [MOBFColor colorWithRGB:0xd9d9d9].CGColor;
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:shareBtn];
    
    [self.view addSubview:scrollView];
}

/**
 分享按钮点击事件
 
 @param shareBtn 分享按钮
 */
- (void)shareBtnClick:(UIButton *)shareBtn
{
    if (self.mobId)
    {
        NSString *pathStr = [NSString stringWithFormat:@"pages/index/index?mobid=%@&custom=来自App的自定义参数", self.mobId];
        NSString *imgPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"miniprogram.jpg"];
        [[MLDTool shareInstance] shareMiniProgramWithTitle:@"MiniProgram For MobLink"
                                               description:@"Test MiniProgram For MobLink"
                                                webPageUrl:@"http://www.mob.com"
                                                      path:pathStr
                                                thumbImage:imgPath
                                                  userName:@"gh_531c99d3b4a7"
                                           withShareTicket:YES
                                           miniProgramType:2
                                           platformSubType:SSDKPlatformSubTypeWechatSession];
    }
    else
    {
        [[MLDTool shareInstance] showAlertWithMessage:@"请先获取MobID！"];
    }
}

// 视图将要消失时关闭所有弹窗
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[MLDTool shareInstance] dismissAlert];
}

/**
 根据mobid修改分享按钮的样式
 
 @param mobId mobid
 */
- (void)changeShareBtnAppearanceWithMobId:(NSString *)mobId
{
    if (mobId)
    {
        [self.shareBtn setTitleColor:[MOBFColor colorWithRGB:0x4B89EA] forState:UIControlStateNormal];
        self.shareBtn.layer.borderColor = [MOBFColor colorWithRGB:0x4B89EA].CGColor;
    }
    else
    {
        [self.shareBtn setTitleColor:[MOBFColor colorWithRGB:0xd9d9d9] forState:UIControlStateNormal];
        self.shareBtn.layer.borderColor = [MOBFColor colorWithRGB:0xd9d9d9].CGColor;
    }
}

/**
 根据内容创建Label
 
 @param text 内容
 @return Label
 */
- (UILabel *)labelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    
    return label;
}

/**
 根据站位文字创建textField
 
 @param placeholder 站位文字
 @return textField
 */
- (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    leftView.backgroundColor = [UIColor clearColor];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:15];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
//    textField.enablesReturnKeyAutomatically = YES;
    textField.layer.cornerRadius = 5.0;
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [MOBFColor colorWithRGB:0xE3E3E3].CGColor;
    return textField;
}

#pragma mark - delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - 业务逻辑

- (void)getMobid
{
    NSMutableDictionary *customParams = [NSMutableDictionary dictionary];
    
    if (self.firstKey.text.length > 0 && self.firstValue.text.length > 0)
    {
        customParams[self.firstKey.text] = self.firstValue.text;
    }
    if (self.secondKey.text.length > 0 && self.secondValue.text.length > 0)
    {
        customParams[self.secondKey.text] = self.secondValue.text;
    }
    if (self.thirdKey.text.length > 0 && self.thirdValue.text.length > 0)
    {
        customParams[self.thirdKey.text] = self.thirdValue.text;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [[MLDTool shareInstance] getMobidWithPath:self.path
                                       source:self.sourceTextField.text
                                       params:customParams.copy
                                       result:^(NSString *mobid) {
                                           weakSelf.mobId = mobid;
                                           [weakSelf changeShareBtnAppearanceWithMobId:mobid];
                                           NSString *msg = mobid == nil ? @"获取Mobid失败" : @"获取Mobid成功";
                                           [[MLDTool shareInstance] showAlertWithMessage:msg];
                                       }];
}

@end
