//
//  MLDTool.h
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MLDAlertView.h"
#import <ShareSDK/ShareSDK.h>

@class MLSDKScene;

@interface MLDTool : NSObject

/**
 获取单例对象
 
 @return 单例对象
 */
+ (MLDTool *)shareInstance;

/**
 获取MobId
 
 @param path 恢复路径
 @param source 来源
 @param params 参数
 @param result 结果回调
 */
- (void)getMobidWithPath:(NSString *)path
                  source:(NSString *)source
                  params:(NSDictionary *)params
                  result:(void (^)(NSString *mobid, NSError *error))result;

/**
 使用用户偏好缓存mobid
 
 @param mobid mobid
 @param keyPath 对应key
 */
- (void)cacheMobid:(NSString *)mobid forKeyPath:(NSString *)keyPath;

/**
 从缓存读取mobid
 
 @param keyPath 对应key
 @return mobid
 */
- (NSString *)mobidForKeyPath:(NSString *)keyPath;

/**
 分享mobid
 
 @param mobid mobid
 @param title 标题
 @param text 内容
 @param imageName 完整图片名称须带后缀
 @param path 相应的路径
 @param onView iPhone可以传nil,但是iPad就必须要传一个分享弹窗的依赖视图,相当于一个锚点
 */
- (void)shareWithMobId:(NSString *)mobid
                 title:(NSString *)title
                  text:(NSString *)text
                 image:(NSString *)imageName
                  path:(NSString *)path
                onView:(UIView *)onView;

/**
 拷贝图片

 @param text text
 @param image 图片
 */
- (void)copyParamWithText:(NSString *)text image:(id)image;

/**
 分享二维码图片

 @param image 图片
 @param text text
 @param title title
 @param onView iPhone可以传nil,但是iPad就必须要传一个分享弹窗的依赖视图,相当于一个锚点
 */
- (void)shareQRCodeImage:(id)image
                    text:(NSString *)text
                   title:(NSString *)title
                  onView:(UIView *)onView;

/**
 分享到微信小程序

 @param title 标题
 @param desc 描述
 @param url 网页链接
 @param path 小程序对应的页面路径
 @param image 卡片封面图
 @param username 小程序开发者名称
 @param shareticket 是否使用带shareTicket的转发
 @param type 小程序的版本（0=正式、1=开发、2=体验）
 @param platformType 分享平台
 */
- (void)shareMiniProgramWithTitle:(NSString *)title
                      description:(NSString *)desc
                       webPageUrl:(NSString *)url
                             path:(NSString *)path
                       thumbImage:(UIImage *)image
                         userName:(NSString *)username
                  withShareTicket:(BOOL)shareticket
                  miniProgramType:(NSUInteger)type
                  platformSubType:(SSDKPlatformType)platformType;

/**
 显示场景信息
 
 @param scene 场景信息
 */
- (void)showAlertWithScene:(MLSDKScene *)scene;

/**
 显示弹窗信息,默认无标题,无点击回调
 
 @param message 信息内容
 */
- (void)showAlertWithMessage:(NSString *)message;

/**
 显示弹窗
 
 @param title 标题
 @param message 信息
 @param cancel 取消按钮标题
 @param other 其他按钮标题
 @param block 点击按钮回调block
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancel
                otherTitle:(NSString *)other
                clickBlock:(MLDAlertClickButtonBlock)block;

/**
 关闭所有弹窗
 */
- (void)dismissAlert;

/**
 执行非空Block
 
 @param block 无参无返回值的Block
 */
- (void)invokingBlockIfNotNil:(void(^)())block;

@end
