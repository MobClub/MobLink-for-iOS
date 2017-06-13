//
//  MLDVideoCollectionViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDVideoCollectionViewController.h"
#import "MLDVideoCollectionViewCell.h"
#import "MLDVideoDetailTableViewController.h"

static NSString * const videoReuseId = @"videoReuseId";

@interface MLDVideoCollectionViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation MLDVideoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"电影视频";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MLDVideoCollectionViewCell class] forCellWithReuseIdentifier:videoReuseId];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 50) / 3.0, 180 * PUBLICSCALE);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLDVideoCollectionViewCell *cell = (MLDVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:videoReuseId forIndexPath:indexPath];
    
    if (indexPath.item < self.dataArray.count)
    {
        cell.dict = self.dataArray[indexPath.item];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLDVideoDetailTableViewController *videoDetailCtr = [[MLDVideoDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    videoDetailCtr.index = indexPath.item;
    [self.navigationController pushViewController:videoDetailCtr animated:YES];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载

- (NSArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Videos" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _dataArray;
}

@end
