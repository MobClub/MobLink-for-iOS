//
//  MLDNewsTableViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDNewsTableViewController.h"
#import "MLDNewsTableViewCell.h"
#import "MLDNewsDetailTableViewController.h"

static NSString *const newsReuseId = @"newsReuseId";

@interface MLDNewsTableViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation MLDNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"今日新闻";
    self.tableView.rowHeight = 80 * PUBLICSCALE;
    [self.tableView registerClass:[MLDNewsTableViewCell class] forCellReuseIdentifier:newsReuseId];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLDNewsTableViewCell *cell = (MLDNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:newsReuseId forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.dict = dict;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLDNewsDetailTableViewController *newsDetailCtr = [[MLDNewsDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    newsDetailCtr.index = indexPath.row;
    [self.navigationController pushViewController:newsDetailCtr animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

@end
