//
//  RightImageButton.m
//  MobLinkDemo
//
//  Created by youzu on 2017/1/14.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "RightImageButton.h"

@implementation RightImageButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height);
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, self.frame.size.height, self.frame.size.height);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

@end
