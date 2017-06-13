//
//  MLDNewsDetailTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDNewsDetailTableViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import "MLDNewsDetailTableViewCell.h"
#import <MobLink/MLSDKScene.h>
#import <MobLink/UIViewController+MLSDKRestore.h>

static NSString *const newsDetailReuseId = @"newsDetailReuseId";

@interface MLDNewsDetailTableViewController()<MLDBackItemHandlerProtocol>

@property (nonatomic, strong) MLSDKScene *scene;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *relatedArray;
@property (weak, nonatomic) UIView *header;
@property (assign, nonatomic) NSInteger relatedIndex;

@property (strong, nonatomic) NSDictionary *currentDict;
@property (strong, nonatomic) NSMutableArray *currentRelatedArray;

@end

@implementation MLDNewsDetailTableViewController

+ (NSString *)MLSDKPath
{
    return @"/scene/news";
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
    self.title = @"今日新闻";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MOBFColor colorWithRGB:0x0077FC] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    
    [self.tableView registerClass:[MLDNewsDetailTableViewCell class] forCellReuseIdentifier:newsDetailReuseId];
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
        if (![obj isKindOfClass:[MLDNewsDetailTableViewController class]])
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

- (void)shareItemClick:(UIButton *)shareBtn
{
    NSString *newsID = nil;
    NSString *path = nil;
    if (self.relatedIndex > 0)
    {
        newsID = [NSString stringWithFormat:@"%ld", (long)self.relatedIndex];
        path = [NSString stringWithFormat:@"/scene/news/%ld",(long)self.relatedIndex];
    }
    else
    {
        newsID = [NSString stringWithFormat:@"%ld", (long)self.index];
        path = [NSString stringWithFormat:@"/scene/news/%ld",(long)self.index];
    }
    
    NSDictionary *params = @{
                             @"newsID" : newsID
                             };
    
    // 先读取缓存的mobid,缓存没有再进行网络请求
    NSString *cacheMobid = [[MLDTool shareInstance] mobidForKeyPath:path];
    NSString *title = self.currentDict[@"title"];
    NSString *text = self.currentDict[@"title"];
    NSString *image = self.currentDict[@"imageName"];
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
        [[MLDTool shareInstance] getMobidWithPath:@"/scene/news"
                                           source:@"MobLinkDemo-News"
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
        if ([self.scene.params[@"newsID"] integerValue] >= 100)
        {
            // 要恢复的是相关新闻
            dataIndex = [self.scene.params[@"newsID"] integerValue] - 100;
            dict = self.relatedArray[dataIndex];
        }
        else
        {
            // 要恢复的是正常新闻
            dataIndex = [self.scene.params[@"newsID"] integerValue];
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, 20, SCREEN_WIDTH - 45 * PUBLICSCALE, 0)];
    titleLabel.text = dict[@"title"];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel sizeToFit];
    
    [header addSubview:titleLabel];
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(titleLabel.frame) + 10, 200, 0)];
    sourceLabel.text = dict[@"source"];
    sourceLabel.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.textAlignment = NSTextAlignmentLeft;
    [sourceLabel sizeToFit];
    
    [header addSubview:sourceLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(sourceLabel.frame), SCREEN_WIDTH - 30 * PUBLICSCALE, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [header addSubview: line];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * PUBLICSCALE, CGRectGetMaxY(line.frame) + 15, SCREEN_WIDTH - 30 * PUBLICSCALE, 0)];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:17];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dic = @{NSKernAttributeName : @1.5f};
    NSString *contentText = dict[@"content"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:contentText attributes:dic];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 15.0;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentText.length)];
    contentLabel.attributedText = attrStr;
    [contentLabel sizeToFit];
    
    [header addSubview:contentLabel];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20 + titleLabel.frame.size.height + 15 + sourceLabel.frame.size.height + contentLabel.frame.size.height + 25);
    self.tableView.tableHeaderView = header;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentRelatedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDNewsDetailTableViewCell *cell = (MLDNewsDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:newsDetailReuseId forIndexPath:indexPath];
    
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
    label.text = @"  相关新闻";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    
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
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsList" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _dataArray;
}

- (NSMutableArray *)relatedArray
{
    if (_relatedArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsRelated" ofType:@"plist"];
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
