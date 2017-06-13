//
//  AppDelegate.swift
//  MobLinkDemo-Swift
//
//  Created by youzu on 2017/6/6.
//  Copyright © 2017年 mob. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame : UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white
        let demoVC = ViewController();
        window?.rootViewController = demoVC;
        window?.makeKeyAndVisible();
        
        // 设置MobLink代理
        MobLink.setDelegate(self)
        
        // 初始化ShareSDK
        self.initShareSDK()
        
        return true
    }
    
    
    // 初始化shareSDK
    func initShareSDK(){
        ShareSDK.registerActivePlatforms([SSDKPlatformType.typeSinaWeibo.rawValue,SSDKPlatformType.typeWechat.rawValue,SSDKPlatformType.typeQQ.rawValue], onImport: { (platform :SSDKPlatformType) in
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:
                ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                
            case SSDKPlatformType.typeWechat:
                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                
            case SSDKPlatformType.typeQQ:
                ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                
            default:
                break
            }
        }) { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
            switch platform
            {
            case SSDKPlatformType.typeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                appInfo?.ssdkSetupSinaWeibo(byAppKey: "474962333",
                                            appSecret : "26522c6ed236057fd4ff5005449f98e9",
                                            redirectUri : "http://www.mob.com",
                                            authType : SSDKAuthTypeBoth)
                
            case SSDKPlatformType.typeWechat:
                appInfo?.ssdkSetupWeChat(byAppId: "wx01634d672597c03c", appSecret: "64020361b8ec4c99936c0e3999a9f249")
                
            case SSDKPlatformType.typeQQ:
                appInfo?.ssdkSetupQQ(byAppId: "1105479028", appKey : "HxHozohsRAkSGREY", authType : SSDKAuthTypeBoth)
                
            default:
                break
            }
        }
    }
    
}


extension AppDelegate: IMLSDKRestoreDelegate
{
    func imlsdkStartCheckScene() {
        print("开始检查场景.")
    }
    
    func imlsdkEndCheckScene() {
        print("结束检查场景.")
    }
    
    /// 将要进行场景恢复
    ///
    /// - Parameters:
    ///   - scene: 场景信息
    ///   - restoreHandler: 恢复回调闭包,实现该方法务必回调该闭包并传入true(恢复)或false(不恢复),期望恢复样式可以选择
    func imlsdkWillRestore(_ scene: MLSDKScene!, restore restoreHandler: ((Bool, RestoreStyle) -> Void)!) {
        print("将要进行场景恢复 path:\(scene.path ?? "")")
        
        // 可根据path决定是否进行场景恢复
        let alertCtr: UIAlertController = UIAlertController(title: "提示", message: "是否恢复场景？", preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "否", style: .cancel) { (action: UIAlertAction) in
            restoreHandler(false, .Default)
        }
        
        let sureAction: UIAlertAction = UIAlertAction(title: "是", style: .default) { (action: UIAlertAction) in
            restoreHandler(true, .Default)
        }
        
        alertCtr.addAction(cancelAction)
        alertCtr.addAction(sureAction)
        
        self.window?.rootViewController?.present(alertCtr, animated: true, completion: nil)
    }
    
    func imlsdkCompleteRestore(_ scene: MLSDKScene!) {
        print("场景恢复完成.")
    }
    
    func imlsdkNotFound(_ scene: MLSDKScene!) {
        print("没有找到控制器路径 path:%@", scene.path)
    }
}
