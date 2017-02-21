//
//  AppDelegate.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/11.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let tabbar = WTKTabbarController()
        window?.rootViewController = tabbar

        registShareSDK()
        
        
        return true
    }
    
    
    func registShareSDK() {
        DispatchQueue.global().async {
            ShareSDK.registerApp("1b7155c23c5d4", activePlatforms: [SSDKPlatformType.subTypeQQFriend.rawValue,SSDKPlatformType.subTypeQZone.rawValue,SSDKPlatformType.typeWechat.rawValue,SSDKPlatformType.subTypeWechatTimeline.rawValue], onImport: { (x) in
                switch x {
//                case .subTypeQQFriend:
//                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
//                    break
//                case .subTypeQZone:
//                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
//                    break
                case .typeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                    break
                case SSDKPlatformType.typeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    break
                    
                case .subTypeWechatTimeline:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    break
                default :
                    break
                }
            }, onConfiguration: { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
                switch platform {
                case .typeWechat:
                    appInfo?.ssdkSetupWeChat(byAppId: "wx75e61fb94ed8a102", appSecret: "683b9e519155bdd56348238508461ecf")
                    break
                case .subTypeWechatTimeline:
                    appInfo?.ssdkSetupWeChat(byAppId: "wx75e61fb94ed8a102", appSecret: "683b9e519155bdd56348238508461ecf")
                    break
                case .typeQQ:
                    appInfo?.ssdkSetupQQ(byAppId: "1105999338", appKey: "2jamh8NgkQSg1hux", authType: SSDKAuthTypeBoth)

                    break
                default :
                    break
                }
            
            })
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

