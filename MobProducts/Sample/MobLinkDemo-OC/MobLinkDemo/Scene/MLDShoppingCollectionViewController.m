//
//  MLDShoppingCollectionViewController.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDShoppingCollectionViewController.h"
#import "MLDShoppingCollectionViewCell.h"
#import "MLDShoppingDetailTableViewController.h"

static NSString * const shoppingReuseId = @"shoppingReuseId";

@interface MLDShoppingCollectionViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation MLDShoppingCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"电商";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MLDShoppingCollectionViewCell class] forCellWithReuseIdentifier:shoppingReuseId];
    
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
    MLDShoppingCollectionViewCell *cell = (MLDShoppingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:shoppingReuseId forIndexPath:indexPath];
    
    if (indexPath.item < self.dataArray.count)
    {
        cell.dict = self.dataArray[indexPath.item];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLDShoppingDetailTableViewController *shoppingDetailCtr = [[MLDShoppingDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    shoppingDetailCtr.index = indexPath.item;
    [self.navigationController pushViewController:shoppingDetailCtr animated:YES];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
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

@end
