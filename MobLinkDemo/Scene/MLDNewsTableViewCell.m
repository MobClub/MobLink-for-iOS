//
//  MLDNewsTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDNewsTableViewCell.h"
#import "UILabel+MLDLabel.h"

@interface MLDNewsTableViewCell()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *subTitleL;

@end

@implementation MLDNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    UILabel *titleL = [[UILabel alloc] init];
    self.titleL = titleL;
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.numberOfLines = 0;
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:titleL];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    self.imageV = imageV;
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:imageV];
    
    UILabel *subTitleL = [[UILabel alloc] init];
    self.subTitleL = subTitleL;
    subTitleL.font = [UIFont systemFontOfSize:11];
    subTitleL.textColor = [UIColor blackColor];
    subTitleL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:subTitleL];
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.imageV.frame = CGRectMake(SCREEN_WIDTH - 20 - ((self.bounds.size.height - 20) * 214.0 / 146.0), 10, (self.bounds.size.height - 20) * 214.0 / 146.0, self.bounds.size.height - 20);
    self.imageV.image = FileImage(dict[@"imageName"]);
    
    CGFloat titleH = [UILabel getHeightByWidth:SCREEN_WIDTH - self.imageV.bounds.size.width - 40 title:dict[@"title"] font:[UIFont systemFontOfSize:15]];
    self.titleL.frame = CGRectMake(15, 10, SCREEN_WIDTH - self.imageV.bounds.size.width - 40, titleH);
    self.titleL.text = dict[@"title"];
    
    NSString *subStr = dict[@"subTitle"];
    CGFloat subTitleH = [UILabel getHeightByWidth:150 title:subStr font:[UIFont systemFontOfSize:11]];
    self.subTitleL.frame = CGRectMake(15, CGRectGetMaxY(self.imageV.frame) - subTitleH, 150, subTitleH);
    self.subTitleL.text = subStr;
    NSMutableAttributedString *mAttriStr = nil;
    if ([subStr hasPrefix:@"置顶"]) {
        NSRange range = [subStr rangeOfString:@"置顶"];
        mAttriStr = [[NSMutableAttributedString alloc] initWithString:subStr];
        [mAttriStr addAttribute:NSForegroundColorAttributeName value:[MOBFColor colorWithRGB:0x4B89EA] range:range];
        self.subTitleL.attributedText = mAttriStr;
    }
}

@end
