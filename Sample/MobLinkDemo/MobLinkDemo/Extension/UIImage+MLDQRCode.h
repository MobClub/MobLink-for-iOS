//
//  UIImage+MLDQRCode.h
//  MobLink
//
//  Created by lujh on 2018/6/19.
//  Copyright © 2018年 Mob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MLDQRCode)

/**
 *  根据字符串生成二维码图片
 *
 *  @param string 二维码code
 *  @param size 生成图片大小
 *
 *  @return uiimage对象
 */
+ (UIImage *)mldCreateQRCodeImageFormString:(NSString *)string withSize:(CGFloat)size;

@end
