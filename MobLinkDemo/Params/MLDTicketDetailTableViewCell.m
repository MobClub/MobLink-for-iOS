//
//  MLDTicketDetailTableViewCell.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDTicketDetailTableViewCell.h"
#import "UILabel+MLDLabel.h"

@interface MLDTicketDetailTableViewCell()

@property (weak, nonatomic) UILabel *departTimeL;
@property (weak, nonatomic) UILabel *departPortL;
@property (weak, nonatomic) UILabel *flyNumberL;
@property (weak, nonatomic) UIImageView *imageV;
@property (weak, nonatomic) UILabel *arriveTimeL;
@property (weak, nonatomic) UILabel *arrivePortL;
@property (weak, nonatomic) UILabel *priceL;
@property (weak, nonatomic) UILabel *discountL;

@end

@implementation MLDTicketDetailTableViewCell

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
    UILabel *departTimeL = [[UILabel alloc] init];
    self.departTimeL = departTimeL;
    departTimeL.font = [UIFont systemFontOfSize:19];
    departTimeL.textColor = [UIColor blackColor];
    departTimeL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:departTimeL];
    
    UILabel *departPortL = [[UILabel alloc] init];
    self.departPortL = departPortL;
    departPortL.font = [UIFont systemFontOfSize:11];
    departPortL.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    departPortL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:departPortL];
    
    UILabel *flyNumberL = [[UILabel alloc] init];
    self.flyNumberL = flyNumberL;
    flyNumberL.font = [UIFont systemFontOfSize:11];
    flyNumberL.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    flyNumberL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:flyNumberL];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jt"]];
    self.imageV = imageV;
    
    [self.contentView addSubview:imageV];
    
    UILabel *arriveTimeL = [[UILabel alloc] init];
    self.arriveTimeL = arriveTimeL;
    arriveTimeL.font = [UIFont systemFontOfSize:19];
    arriveTimeL.textColor = [UIColor blackColor];
    arriveTimeL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:arriveTimeL];
    
    UILabel *arrivePortL = [[UILabel alloc] init];
    self.arrivePortL = arrivePortL;
    arrivePortL.font = [UIFont systemFontOfSize:11];
    arrivePortL.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    arrivePortL.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:arrivePortL];
    
    UILabel *priceL = [[UILabel alloc] init];
    self.priceL = priceL;
    priceL.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:priceL];
    
    UILabel *discountL = [[UILabel alloc] init];
    self.discountL = discountL;
    discountL.font = [UIFont systemFontOfSize:11];
    discountL.textColor = [MOBFColor colorWithRGB:0xa4a4a4];
    discountL.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:discountL];
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    NSString *departTime = dict[@"departTime"];
    CGFloat departTimeLWidth = [UILabel getWidthWithTitle:departTime font:[UIFont systemFontOfSize:19]];
    self.departTimeL.frame = CGRectMake(15, 18, departTimeLWidth, 0);
    self.departTimeL.text = departTime;
    [self.departTimeL sizeToFit];
    
    NSString *departPort = dict[@"departPort"];
    CGFloat departPortLWidth = [UILabel getWidthWithTitle:departPort font:[UIFont systemFontOfSize:11]];
    self.departPortL.frame = CGRectMake(15, CGRectGetMaxY(self.departTimeL.frame) + 10, departPortLWidth, 0);
    self.departPortL.text = departPort;
    [self.departPortL sizeToFit];
    
    NSString *flyNumber = dict[@"flyNumber"];
    CGFloat flyNumberLWidth = [UILabel getWidthWithTitle:flyNumber font:[UIFont systemFontOfSize:11]];
    self.flyNumberL.frame = CGRectMake(15, CGRectGetMaxY(self.departPortL.frame) + 10, flyNumberLWidth, 0);
    self.flyNumberL.text = flyNumber;
    [self.flyNumberL sizeToFit];
    
    self.imageV.frame = CGRectMake(CGRectGetMaxX(self.departTimeL.frame) + 20 * PUBLICSCALE, CGRectGetMaxY(self.departTimeL.frame) - 10, 0, 0);
    [self.imageV sizeToFit];
    
    NSString *arriveTime = dict[@"arriveTime"];
    CGFloat arriveTimeLWidth = [UILabel getWidthWithTitle:arriveTime font:[UIFont systemFontOfSize:19]];
    self.arriveTimeL.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 20 * PUBLICSCALE, 18, arriveTimeLWidth, 0);
    self.arriveTimeL.text = arriveTime;
    [self.arriveTimeL sizeToFit];
    
    NSString *arrivePort = dict[@"arrivePort"];
    CGFloat arrivePortLWidth = [UILabel getWidthWithTitle:arrivePort font:[UIFont systemFontOfSize:11]];
    self.arrivePortL.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + 20 *PUBLICSCALE, CGRectGetMaxY(self.arriveTimeL.frame) + 10, arrivePortLWidth, 0);
    self.arrivePortL.text = arrivePort;
    [self.arrivePortL sizeToFit];
    
    NSString *price = dict[@"price"];
    self.priceL.frame = CGRectMake(CGRectGetMaxX(self.arriveTimeL.frame), 18, SCREEN_WIDTH - CGRectGetMaxX(self.arriveTimeL.frame) - 15, 25);
    NSDictionary *mdic = @{
                           NSForegroundColorAttributeName : [MOBFColor colorWithRGB:0xFF8013],
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:11]
                           };
    NSMutableAttributedString *mPriceStr = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:mdic];
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [MOBFColor colorWithRGB:0xFF8013],
                          NSFontAttributeName : [UIFont boldSystemFontOfSize:23]
                          };
    NSAttributedString *priceStr = [[NSAttributedString alloc] initWithString:price attributes:dic];
    [mPriceStr appendAttributedString:priceStr];
    self.priceL.attributedText = mPriceStr;
    
    NSString *discount = dict[@"discount"];
    self.discountL.frame = CGRectMake(CGRectGetMaxX(self.arrivePortL.frame), self.arrivePortL.frame.origin.y, SCREEN_WIDTH - CGRectGetMaxX(self.arrivePortL.frame) - 15, self.arrivePortL.frame.size.height);
    self.discountL.text = discount;
}

@end
