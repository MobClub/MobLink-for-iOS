//
//  MLDVideoDetailTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/10/25.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDVideoDetailTableViewCell.h"

@interface MLDVideoDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation MLDVideoDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.countLabel.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
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
    
    NSString *count = dict[@"count"];
    self.countLabel.text = count;
}

@end
