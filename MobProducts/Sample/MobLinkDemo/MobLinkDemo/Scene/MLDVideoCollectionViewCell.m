//
//  MLDVideoCollectionViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDVideoCollectionViewCell.h"

@interface MLDVideoCollectionViewCell()

@property (assign, nonatomic) CGRect frame;
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *titleLabel;

@end

@implementation MLDVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = frame;
        
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageV = imageV;
        [self.contentView addSubview:imageV];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    NSString *imageName = dict[@"image"];
    self.imageV.image = FileImage(imageName);
    self.imageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40);
    
    NSString *title = dict[@"title"];
    self.titleLabel.text = title;
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame), self.frame.size.width, 40);
}

@end
