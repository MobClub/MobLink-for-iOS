//
//  MLDVideoDetailTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDVideoDetailTableViewCell.h"

@interface MLDVideoDetailTableViewCell()

@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *countLabel;

@end

@implementation MLDVideoDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView *imageV = [[UIImageView alloc] init];
        self.imageV = imageV;
        
        [self.contentView addSubview:imageV];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:titleLabel];
        
        UILabel *countLabel = [[UILabel alloc] init];
        self.countLabel = countLabel;
        countLabel.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
        countLabel.textAlignment = NSTextAlignmentLeft;
        countLabel.font = [UIFont systemFontOfSize:11];
        
        [self.contentView addSubview:countLabel];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    NSString *imageName = dict[@"image"];
    self.imageV.frame = CGRectMake(10, 5, (self.frame.size.height - 10) * 232.0 / 132.0, self.frame.size.height - 10);
    self.imageV.image = FileImage(imageName);
    
    NSString *title = dict[@"title"];
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 10, 5, self.frame.size.width - CGRectGetMaxX(self.imageV.frame) - 10, 0);
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    NSString *count = dict[@"count"];
    self.countLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+ 10, CGRectGetMaxY(self.imageV.frame) - 15, 150, 15);
    self.countLabel.text = count;
}

@end
