//
//  MLDShoppingDetailTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDShoppingDetailTableViewCell.h"

@interface MLDShoppingDetailTableViewCell()

@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *priceLabel;

@end

@implementation MLDShoppingDetailTableViewCell

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
        
        UILabel *priceLabel = [[UILabel alloc] init];
        self.priceLabel = priceLabel;
        priceLabel.textColor = [MOBFColor colorWithRGB:0xEC6159];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:18];
        
        [self.contentView addSubview:priceLabel];
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
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 10, 5, self.frame.size.width - CGRectGetMaxX(self.imageV.frame) - 40, 40);
    self.titleLabel.text = title;
    
    NSString *price = dict[@"price"];
    self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 10, CGRectGetMaxY(self.imageV.frame) - 20, 150, 20);
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
}

@end
