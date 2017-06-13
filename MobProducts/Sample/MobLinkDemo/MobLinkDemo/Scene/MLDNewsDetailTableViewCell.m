//
//  MLDNewsDetailTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDNewsDetailTableViewCell.h"

@interface MLDNewsDetailTableViewCell()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *subTitleL;

@end

@implementation MLDNewsDetailTableViewCell

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
    UIImageView *imageV = [[UIImageView alloc] init];
    self.imageV = imageV;
    
    [self.contentView addSubview:imageV];
    
    UILabel *titleL = [[UILabel alloc] init];
    self.titleL = titleL;
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.numberOfLines = 0;
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:titleL];
    
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
    
    self.imageV.frame = CGRectMake(10, 5, (self.frame.size.height - 10) * 232.0 / 132.0, self.frame.size.height - 10);
    self.imageV.image = FileImage(dict[@"imageName"]);
    
    self.titleL.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 10, 5, SCREEN_WIDTH - self.imageV.bounds.size.width - 40, 40);
    self.titleL.text = dict[@"title"];
    
    NSString *subStr = dict[@"subTitle"];
    self.subTitleL.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 10, CGRectGetMaxY(self.imageV.frame) - 20, 100, 20);
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
