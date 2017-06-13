//
//  MLDShoppingDetailTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDShoppingDetailTableViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import "MLDShoppingDetailTableViewCell.h"
#import "UILabel+MLDLabel.h"
#import <MobLink/MLSDKScene.h>
#import <MobLink/UIViewController+MLSDKRestore.h>

static NSString *const shoppingDetailReuseId = @"shoppingDetailReuseId";

@interface MLDShoppingDetailTableViewController()<MLDBackItemHandlerProtocol>

@property (nonatomic, strong) MLSDKScene *scene;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *relatedArray;
@property (strong, nonatomic) UIWindow *bottomWindow;
@property (strong, nonatomic) UIButton *bottomBtn;
@property (weak, nonatomic) UIView *header;
@property (assign, nonatomic) NSInteger relatedIndex;
@property (strong, nonatomic) NSDictionary *currentDict;
@property (strong, nonatomic) NSMutableArray *currentRelatedArray;

@end

@implementation MLDShoppingDetailTableViewController

+ (NSString *)MLSDKPath
{
    return @"/scene/shopping";
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
    self.title = @"商品详情";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MOBFColor colorWithRGB:0x0077FC] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    
    [self.tableView registerClass:[MLDShoppingDetailTableViewCell class] forCellReuseIdentifier:shoppingDetailReuseId];
    self.tableView.rowHeight = 80 * PUBLICSCALE;
    
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
        if (![obj isKindOfClass:[MLDShoppingDetailTableViewController class]])
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
    
    [_bottomWindow resignKeyWindow];
    _bottomWindow = nil;
    [_bottomBtn removeFromSuperview];
    _bottomBtn = nil;
    
    [[MLDTool shareInstance] dismissAlert];
}

- (void)shareItemClick:(UIButton *)shareBtn
{
    NSString *goodsID = nil;
    NSString *path = nil;
    if (self.relatedIndex > 0)
    {
        goodsID = [NSString stringWithFormat:@"%ld", (long)self.relatedIndex];
        path = [NSString stringWithFormat:@"/scene/shopping/%ld",(long)self.relatedIndex];
    }
    else
    {
        goodsID = [NSString stringWithFormat:@"%ld", (long)self.index];
        path = [NSString stringWithFormat:@"/scene/shopping/%ld",(long)self.index];
    }
    
    NSDictionary *params = @{
                             @"goodsID" : goodsID
                             };
    // 先读取缓存的mobid,缓存没有再进行网络请求
    NSString *cacheMobid = [[MLDTool shareInstance] mobidForKeyPath:path];
    NSString *title = self.currentDict[@"title"];
    NSString *text = self.currentDict[@"title"];
    NSString *image = self.currentDict[@"image"];
    if (cacheMobid)
    {
        [[MLDTool shareInstance] shareWithMobId:cacheMobid
                                          title:title
                                           text:text
                                          image:image
                                           path:path
                                         onView:shareBtn];
    }
    else
    {
        [[MLDTool shareInstance] getMobidWithPath:@"/scene/shopping"
                                           source:@"MobLinkDemo-Shopping"
                                           params:params
                                           result:^(NSString *mobid) {
                                                 // 先缓存mobid,如果有的话
                                                 if (mobid)
                                                 {
                                                     [[MLDTool shareInstance] cacheMobid:mobid forKeyPath:path];
                                                 }
                                                 
                                                 [[MLDTool shareInstance] shareWithMobId:mobid
                                                                                   title:title
                                                                                    text:text
                                                                                   image:image
                                                                                    path:path
                                                                                  onView:shareBtn];
                                             }];
    }
}

- (void)setupUI
{
    NSInteger dataIndex = 0;
    NSDictionary *dict = nil;
    if (self.scene)
    {
        if ([self.scene.params[@"goodsID"] integerValue] >= 100)
        {
            // 要恢复的是相关商品
            dataIndex = [self.scene.params[@"goodsID"] integerValue] - 100;
            dict = self.relatedArray[dataIndex];
        }
        else
        {
            // 要恢复的是正常商品
            dataIndex = [self.scene.params[@"goodsID"] integerValue];
            dict = self.dataArray[dataIndex];
        }
    }
    else
    {
        dataIndex = self.index;
        dict = self.dataArray[dataIndex];
    }
    
    [self refreshHeaderWith:dict];
}

/**
 刷新tableViewHeader
 
 @param dict 字典
 */
- (void)refreshHeaderWith:(NSDictionary *)dict
{
    self.currentDict = dict;
    //清除header
    [self.header removeFromSuperview];
    self.header = nil;
    self.tableView.tableHeaderView = nil;
    
    // header
    UIView *header = [[UIView alloc] init];
    self.header = header;
    header.backgroundColor = [UIColor whiteColor];
    
    NSString *imageName = dict[@"image"];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 330 / 1.265) / 2.0, 0, 330 / 1.265, 330)];
    imageV.image = FileImage(imageName);
    [header addSubview:imageV];
    
    NSString *title = dict[@"title"];
    CGFloat titleH = 20;
    CGFloat headerH = 400;
    CGFloat titleW = [UILabel getWidthWithTitle:title font:[UIFont systemFontOfSize:14]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:title];
    if (titleW > SCREEN_WIDTH - 30)
    {
        titleH = 50;
        headerH = 418;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10.0;
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title.length)];
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(imageV.frame) + 10, SCREEN_WIDTH - 30, titleH)];
    titleLabel.attributedText = attrStr;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.numberOfLines = 0;
    [header addSubview:titleLabel];
    
    NSString *price = dict[@"price"];
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + 10, SCREEN_WIDTH - 30, 20)];
    priceLabel.text = [NSString stringWithFormat:@"¥%@", price];
    priceLabel.textColor = [MOBFColor colorWithRGB:0xEC6159];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:18];
    [header addSubview:priceLabel];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, headerH);
    
    self.tableView.tableHeaderView = header;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [_bottomBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
    [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _bottomBtn.backgroundColor = [MOBFColor colorWithRGB:0x9D9D9D];
    //    [_bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _bottomWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    _bottomWindow.windowLevel = UIWindowLevelAlert;
    _bottomWindow.backgroundColor = [UIColor whiteColor];
    [_bottomWindow addSubview:_bottomBtn];
    [_bottomWindow makeKeyAndVisible];
}

// 该方法暂时不用
- (void)bottomBtnClick:(UIButton *)button
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"立即购买"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentRelatedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDShoppingDetailTableViewCell *cell = (MLDShoppingDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:shoppingDetailReuseId forIndexPath:indexPath];
    
    if (indexPath.row < self.currentRelatedArray.count)
    {
        cell.dict = self.currentRelatedArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.currentRelatedArray[indexPath.row];
    self.relatedIndex = [dict[@"index"] integerValue];
    [self refreshHeaderWith:dict];
    
    [self.currentRelatedArray removeAllObjects];
    [self.relatedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        if ([dict[@"index"] integerValue] != self.relatedIndex)
        {
            [self.currentRelatedArray addObject:obj];
        }
    }];
    
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    label.text = @"  相关推荐";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - 懒加载

- (NSArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _dataArray;
}

- (NSMutableArray *)relatedArray
{
    if (_relatedArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ProductsRelated" ofType:@"plist"];
        _relatedArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    return _relatedArray;
}

- (NSMutableArray *)currentRelatedArray
{
    if (_currentRelatedArray == nil)
    {
        _currentRelatedArray = [NSMutableArray arrayWithCapacity:2];
        if ([self.currentDict[@"index"] integerValue] >= 100)
        {
            [self.relatedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = obj;
                if (![dict[@"index"] isEqualToString:self.currentDict[@"index"]])
                {
                    [_currentRelatedArray addObject:obj];
                }
            }];
        }
        else
        {
            [self.relatedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_currentRelatedArray addObject:obj];
                if (idx == 1)
                {
                    *stop = YES;
                }
            }];
        }
    }
    return _currentRelatedArray;
}

@end
