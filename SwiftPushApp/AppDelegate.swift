//
//  AppDelegate.swift
//  SwiftPushApp
//
//  Created by Natsumo Ikeda on 2016/06/09.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //********** APIキーの設定 **********
    let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
    let clientkey      = "YOUR_NCMB_CLIENTKEY"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //********** SDKの初期化 **********
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        
        /// デバイストークンの要求
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
            /** iOS8以上 **/
             //通知のタイプを設定したsettingを用意
            let type : UIUserNotificationType = [.Alert, .Badge, .Sound]
            let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
            //通知のタイプを設定
            application.registerUserNotificationSettings(setting)
            //DevoceTokenを要求
            application.registerForRemoteNotifications()
        }else{
            /** iOS8未満 **/
            let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
        }
        
        
        return true
    }
    
    // デバイストークンが取得されたら呼び出されるメソッド
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
        // 端末情報を扱うNCMBInstallationのインスタンスを作成
        let installation = NCMBInstallation.currentInstallation()
        // デバイストークンの設定
        installation.setDeviceTokenFromData(deviceToken)
        // 端末情報をデータストアに登録
        installation.saveInBackgroundWithBlock { (error: NSError!) -> Void in
            if (error != nil){
                // 端末情報の登録に失敗した時の処理
                
            }else{
                // 端末情報の登録に成功した時の処理
                
            }
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

