//
//  MLDVideoDetailTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDVideoDetailTableViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import "MLDVideoDetailTableViewCell.h"
#import <MobLink/MLSDKScene.h>
#import <MobLink/UIViewController+MLSDKRestore.h>

static NSString *const videoDetailReuseId = @"videoDetailReuseId";

@interface MLDVideoDetailTableViewController()<MLDBackItemHandlerProtocol, UIWebViewDelegate>

@property (nonatomic, strong) MLSDKScene *scene;

@property (weak, nonatomic) UIWebView *webView;
@property (weak, nonatomic) UIActivityIndicatorView *indicator;
@property (weak, nonatomic) UIView *coverView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *relatedArray;
@property (strong, nonatomic) UILabel *sectionHeader;
@property (copy, nonatomic) NSString *urlString;
@property (assign, nonatomic) NSInteger relatedIndex;
@property (strong, nonatomic) NSDictionary *currentDict;
@property (strong, nonatomic) NSMutableArray *currentRelatedArray;

@end

@implementation MLDVideoDetailTableViewController

+ (NSString *)MLSDKPath
{
    return @"/scene/video";
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
    
    NSInteger dataIndex = 0;
    NSDictionary *dict = nil;
    if (self.scene)
    {
        if ([self.scene.params[@"videoID"] integerValue] >= 100)
        {
            // 要恢复的是相关视频
            dataIndex = [self.scene.params[@"videoID"] integerValue] - 100;
            dict = self.relatedArray[dataIndex];
        }
        else
        {
            // 要恢复的是正常视频
            dataIndex = [self.scene.params[@"videoID"] integerValue];
            dict = self.dataArray[dataIndex];
        }
    }
    else
    {
        dataIndex = self.index;
        dict = self.dataArray[dataIndex];
    }
    self.currentDict = dict;
    self.title = dict[@"title"];
    self.urlString = dict[@"url"];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[MOBFColor colorWithRGB:0x0077FC] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = shareItme;
    
    [self.tableView registerClass:[MLDVideoDetailTableViewCell class] forCellReuseIdentifier:videoDetailReuseId];
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
        if (![obj isKindOfClass:[MLDVideoDetailTableViewController class]])
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
    NSString *videoID = nil;
    NSString *path = nil;
    if (self.relatedIndex > 0)
    {
        videoID = [NSString stringWithFormat:@"%ld", (long)self.relatedIndex];
        path = [NSString stringWithFormat:@"/scene/video/%ld",(long)self.relatedIndex];
    }
    else
    {
        videoID = [NSString stringWithFormat:@"%ld", (long)self.index];
        path = [NSString stringWithFormat:@"/scene/video/%ld",(long)self.index];
    }
    
    NSDictionary *params = @{
                             @"videoID" : videoID
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
        [[MLDTool shareInstance] getMobidWithPath:@"/scene/video"
                                             source:@"MobLinkDemo-Videos"
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
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9.0 / 16.0)];
    self.webView = webView;
    webView.delegate = self;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [webView loadRequest:req];
    
    UIView *coverView = [[UIView alloc] initWithFrame:webView.bounds];
    self.coverView = coverView;
    coverView.backgroundColor = [UIColor blackColor];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator = indicator;
    indicator.hidesWhenStopped = YES;
    indicator.bounds = CGRectMake(0, 0, 50, 50);
    indicator.center = CGPointMake(coverView.bounds.size.width / 2.0, coverView.bounds.size.height / 2.0);
    [indicator startAnimating];
    
    [coverView addSubview:indicator];
    
    [webView addSubview:coverView];
    
    self.tableView.tableHeaderView = webView;
}

- (void)refreshHeaderWith:(NSString *)urlString
{
    [self.indicator startAnimating];
    self.coverView.hidden = NO;
    [self.webView stopLoading];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:req];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
    self.coverView.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentRelatedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDVideoDetailTableViewCell *cell = (MLDVideoDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:videoDetailReuseId forIndexPath:indexPath];
    
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
    self.currentDict = dict;
    self.relatedIndex = [dict[@"index"] integerValue];
    self.title = dict[@"title"];
    [self refreshHeaderWith:dict[@"url"]];
    
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
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.sectionHeader = sectionHeader;
    sectionHeader.text = @"  专题联播";
    sectionHeader.font = [UIFont systemFontOfSize:14];
    sectionHeader.textColor = [UIColor blackColor];
    sectionHeader.textAlignment = NSTextAlignmentLeft;
    
    return sectionHeader;
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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}

- (NSMutableArray *)relatedArray
{
    if (_relatedArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"VideosRelated" ofType:@"plist"];
        _relatedArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    return _relatedArray;
}

- (NSMutableArray *)currentRelatedArray
{
    if (_currentRelatedArray == nil)
    {
        _currentRelatedArray = [NSMutableArray arrayWithCapacity:3];
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
                if (idx == 2)
                {
                    *stop = YES;
                }
            }];
        }
    }
    return _currentRelatedArray;
}

@end
