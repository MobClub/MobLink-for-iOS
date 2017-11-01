//
//  MLDNewsTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/10/25.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDNewsTableViewCell.h"

@interface MLDNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *subTitleL;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@end

@implementation MLDNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.imageV.image = FileImage(dict[@"imageName"]);
    self.titleL.text = dict[@"title"];
    NSString *subStr = dict[@"subTitle"];
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
