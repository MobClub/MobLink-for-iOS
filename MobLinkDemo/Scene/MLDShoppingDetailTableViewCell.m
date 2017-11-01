//
//  MLDShoppingDetailTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/10/25.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDShoppingDetailTableViewCell.h"

@interface MLDShoppingDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MLDShoppingDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.priceLabel.textColor = [MOBFColor colorWithRGB:0xEC6159];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    NSString *imageName = dict[@"image"];
    self.imageV.image = FileImage(imageName);
    
    NSString *title = dict[@"title"];
    self.titleLabel.text = title;
    
    NSString *price = dict[@"price"];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
}

@end
