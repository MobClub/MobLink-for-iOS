//
//  MLDTool.m
//  MobLinkDemo
//
//  Created by youzu on 2017/2/15.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MLDTool.h"

#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <MobLink/MobLink.h>
#import <MobLink/MLSDKScene.h>

static NSString *const baseShareUrl = @"http://f.moblink.mob.com";

@interface MLDTool()

@property (weak, nonatomic) MLDAlertView *msgAlert;
@property (weak, nonatomic) MLDAlertView *sceneAlert;

@end

@implementation MLDTool
/**
 获取单例对象
 
 @return 单例对象
 */
+ (MLDTool *)shareInstance
{
    static MLDTool *_instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[MLDTool alloc] init];
    });
    
    return _instance;
}

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
                  result:(void (^)(NSString *mobid))result
{
    MLSDKScene *scene = [[MLSDKScene alloc] initWithMLSDKPath:path source:source params:params];
    
    [MobLink getMobId:scene result:result];
}

/**
 使用用户偏好缓存mobid
 
 @param mobid mobid
 @param keyPath 对应key
 */
- (void)cacheMobid:(NSString *)mobid forKeyPath:(NSString *)keyPath
{
    [[NSUserDefaults standardUserDefaults] setObject:mobid forKey:keyPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 从缓存读取mobid
 
 @param keyPath 对应key
 @return mobid
 */
- (NSString *)mobidForKeyPath:(NSString *)keyPath
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyPath];
}


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
                onView:(UIView *)onView
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString *urlStr = nil;
    if (path)
    {
        urlStr = [NSString stringWithFormat:@"%@%@",baseShareUrl, path];
        if (mobid)
        {
            urlStr = [NSString stringWithFormat:@"%@%@?mobid=%@",baseShareUrl, path, mobid];
        }
    }
    else
    {
        urlStr = [NSString stringWithFormat:@"%@?mobid=%@",baseShareUrl, mobid];
    }
    NSURL *shareUrl = [NSURL URLWithString:urlStr];
    
    [shareParams SSDKSetupShareParamsByText:text
                                     images:FileImage(imageName)
                                        url:shareUrl
                                      title:title
                                       type:SSDKContentTypeWebPage];
    
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeSinaWeibo])
    {
        [shareParams SSDKEnableUseClientShare];
    }
    else
    {
        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@%@",text,urlStr]
                                                   title:title
                                                   image:FileImage(imageName)
                                                     url:nil
                                                latitude:0
                                               longitude:0
                                                objectID:nil
                                                    type:SSDKContentTypeImage];
    }
    
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    
    NSMutableArray *platformItems = [NSMutableArray arrayWithObject:@(SSDKPlatformTypeSinaWeibo)];
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat])
    {
        [platformItems addObjectsFromArray:@[@(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline)]];
    }
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ])
    {
        [platformItems addObject:@(SSDKPlatformTypeQQ)];
    }
    
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:[MOBFDevice isPad] ? onView : nil
                                                                     items:platformItems
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           
                                                           switch (state)
                                                           {
                                                               case SSDKResponseStateSuccess:
                                                                   [self showAlertWithMessage:@"分享成功！"];
                                                                   break;
                                                               case SSDKResponseStateFail:
                                                                   [self showAlertWithMessage:@"分享失败！"];
                                                                   break;
                                                                   
                                                               default:
                                                                   break;
                                                           }
                                                       }];
    
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
}

/**
 显示弹窗信息,默认无标题,无点击回调

 @param message 信息内容
 */
- (void)showAlertWithMessage:(NSString *)message
{
    [self showAlertWithTitle:nil
                     message:message
                 cancelTitle:@"关闭"
                  otherTitle:nil
                  clickBlock:nil];
}

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
                clickBlock:(MLDAlertClickButtonBlock)block
{
    MLDAlertView *msgAlertView = [[MLDAlertView alloc] initWithTitle:title
                                                                 message:message
                                                          cancelBtnTitle:cancel
                                                           otherBtnTitle:other
                                                              clickBlock:block
                                                                    type:MLDShowContentTypeLabel];
    self.msgAlert = msgAlertView;
    
    [msgAlertView show];
}

/**
 显示场景信息专用的弹窗
 
 @param scene 场景信息
 */
- (void)showAlertWithScene:(MLSDKScene *)scene
{
    NSString *path = scene.path == nil ? @"" : scene.path;
    NSString *source = scene.source == nil ? @"" : scene.source;
    __block NSMutableString *msg = [NSMutableString stringWithFormat:@"路径path\n%@ \n\n来源\n%@ \n\n参数", path, source];
    [scene.params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [msg appendFormat:@"\n%@ : %@;", key, obj];
    }];
    
    MLDAlertView *sceneAlertView = [[MLDAlertView alloc] initWithTitle:@"参数"
                                                                   message:msg.copy
                                                            cancelBtnTitle:@"关闭"
                                                             otherBtnTitle:nil
                                                                clickBlock:nil
                                                                      type:MLDShowContentTypeTextView];
    self.sceneAlert = sceneAlertView;
    
    [sceneAlertView show];
}

/**
 关闭所有弹窗
 */
- (void)dismissAlert
{
    [self.msgAlert dismiss];
    [self.sceneAlert dismiss];
}

/**
 执行非空Block
 
 @param block 无参无返回值的Block
 */
- (void)invokingBlockIfNotNil:(void(^)())block
{
    if (block) {
        block();
    }
}
@end
