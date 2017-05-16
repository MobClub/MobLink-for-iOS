//
//  MobLink.h
//  MobLink
//
//  Created by chenjd on 16/11/14.
//  Copyright © 2016年 Mob. All rights reserved.
//  线上

#import <Foundation/Foundation.h>
#import "IMLSDKRestoreDelegate.h"

@class MLSDKScene;

@interface MobLink : NSObject

/**
 初始化MobLink

 @param appKey MobLink应用标识,可在http://mob.com中登录并创建App后获得。
 */
+ (void)registerApp:(NSString *)appKey;

/**
 获取MobId

 @param scene 当前场景信息(即传入您需要还原的场景)
 @param result 回调处理,返回mobid
 */
+ (void)getMobId:(MLSDKScene *)scene result:(void (^)(NSString *mobid))result;

/**
 设置场景恢复委托

 @param delegate 委托对象
 */
+ (void)setDelegate:(id <IMLSDKRestoreDelegate>)delegate;

@end
