//
//  CustomButton.m
//  MobLink
//
//  Created by youzu on 2017/1/10.
//  Copyright © 2017年 Mob. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.frame.size.width - 80) / 2.0, (self.frame.size.height - 92) / 2.0, 80, 53);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 21, self.frame.size.width, 18);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
