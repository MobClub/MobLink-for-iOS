//
//  MLDTicketDetailTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDTicketDetailTableViewController.h"
#import "UIViewController+MLDBackItemHandler.h"
#import "MLDTicketDetailTableViewCell.h"
#import <MobLink/MLSDKScene.h>
#import <MobLink/UIViewController+MLSDKRestore.h>

static NSString *const ticketDetailReuseId = @"ticketDetailReuseId";

@interface MLDTicketDetailTableViewController()<MLDBackItemHandlerProtocol>

@property (nonatomic, strong) MLSDKScene *scene;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation MLDTicketDetailTableViewController

+ (NSString *)MLSDKPath
{
    return @"/params/ticket";
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
    
    NSDictionary *params = self.scene.params;
    if (params.allKeys.count > 0)
    {
        self.title = params[@"date"];
    }
    else
    {
        self.title = self.date;
    }
    
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[MLDTicketDetailTableViewCell class] forCellReuseIdentifier:ticketDetailReuseId];
    
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
        if (![obj isKindOfClass:[MLDTicketDetailTableViewController class]])
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDTicketDetailTableViewCell *cell = (MLDTicketDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ticketDetailReuseId forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSMutableDictionary *mdict = dict.mutableCopy;
    NSDictionary *params = self.scene.params;
    if (params.allKeys.count > 0)
    {
        mdict[@"departPort"] = params[@"from"];
        mdict[@"arrivePort"] = params[@"to"];
    }
    else
    {
        mdict[@"departPort"] = self.from;
        mdict[@"arrivePort"] = self.to;
    }
    
    cell.dict = mdict;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载

- (NSArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Tickets" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}

@end
