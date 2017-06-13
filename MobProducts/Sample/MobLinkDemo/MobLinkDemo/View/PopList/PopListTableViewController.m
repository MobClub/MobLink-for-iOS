//
//  PopListTableViewController.m
//  TestDemo
//
//  Created by youzu on 2017/1/9.
//  Copyright © 2017年 youzu. All rights reserved.
//

#import "PopListTableViewController.h"

@interface PopListTableViewController ()

@property (weak, nonatomic) UITableViewCell *selCell;

@end

static NSString *const popListReuseId = @"popListReuseId";

@implementation PopListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    // 清除多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 边界处理
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [MOBFColor colorWithRGB:0xE3E3E3].CGColor;
    
    self.tableView.rowHeight = 40;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:popListReuseId];
    
    // 默认关闭
    self.isOpen = NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen)
    {
        return 4;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:popListReuseId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.listSource[indexPath.row];
    cell.textLabel.textColor = self.titleColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    //分割线偏移
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selCell.textLabel.textColor = self.titleColor;
    UITableViewCell *curCell = [tableView cellForRowAtIndexPath:indexPath];
    curCell.textLabel.textColor = [MOBFColor colorWithRGB:0x4B89EA];
    self.selCell = curCell;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedBlock)
    {
        self.selectedBlock(indexPath.row);
    }
}

@end
