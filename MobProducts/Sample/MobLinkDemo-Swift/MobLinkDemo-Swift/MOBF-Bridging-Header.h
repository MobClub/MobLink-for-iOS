//
//  MOBF-Bridging-Header.h
//  MobLinkDemo
//
//  Created by chenjd on 17/2/4.
//  Copyright © 2017年 Mob. All rights reserved.
//

#ifndef MOBF_Bridging_Header_h
#define MOBF_Bridging_Header_h

#import <MOBFoundation/MOBFoundation.h>
#import <MobLink/MobLink.h>
#import <MobLink/MLSDKScene.h>
#import <MobLink/IMLSDKRestoreDelegate.h>
#import <MobLink/UIViewController+MLSDKRestore.h>


/***************以下库仅为实现分享功能所用,MobLink的集成不需要依赖以下各库******************/

//ShareSDK相关头文件(MobLink集成非必须)
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>

//新浪微博SDK头文件
#import "WeiboSDK.h"

//腾讯SDK头文件(MobLink集成非必须)
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件(MobLink集成非必须)
#import "WXApi.h"

#endif /* MOBF_Bridging_Header_h */
