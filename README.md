# Swiftアプリにプッシュ通知を組み込もう！
ハンズオンセミナー【Swiftアプリにプッシュ通知を組み込もう！】のコーディング時に使用するコピペ用ページです

* 別に配布の資料のページと一致する部分のコードのみ記載しています。
* 詳しい進め方等は資料をご覧ください。

## P13～P15 ターミナル
        $ cd[ディレクトリ]

        $ ls

        // はじめて使う場合
        $ sudogem install cocoapods

        // 既にインストールしている場合
        $ sudogem update --system

        $ pod setup
        
        $ pod --version

        $ pod init


## P16 Podfile

        platform :ios,'8.0'
        target "pushTestApp" do
            pod 'NCMB', :git => 'https://github.com/NIFTYCloud-mbaas/ncmb_ios.git'
        end 

## P17 ターミナル
 
        $ pod install

## P19 pushTestApp-Bridging-Header.h

        #import <NCMB/NCMB.h>

## P23 AppDelegate.swift

        //********** APIキーの設定**********
        let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
        let clientkey = "YOUR_NCMB_CLIENTKEY"

※「YOUR_NCMB_APPLICATIONKEY」と「YOUR_NCMB_CLIENTKEY」はmBaaSダッシュボードから各自コピペしてください。

## P24 AppDelegate.swift

        //********** SDKの初期化**********
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)

## P26 AppDelegate.swift

        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
            /** iOS8以上での、DeviceToken要求方法**/
            // 通知のタイプを設定したsettingを用意
            let type : UIUserNotificationType = [.Alert, .Badge, .Sound]
            let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
            // 通知のタイプを設定
            application.registerUserNotificationSettings(setting)
            application.registerForRemoteNotifications()
        }else{
            /** iOS8未満での、DeviceToken要求方法**/
            let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            // 通知のタイプを設定
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
        }

## P28 AppDelegate.swift
        func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
            // 端末情報を扱うNCMBInstallationのインスタンスを作成
            let installation = NCMBInstallation.currentInstallation()
            // DeviceTokenの設定
            installation.setDeviceTokenFromData(deviceToken)
            // 端末情報をデータストアに登録
            installation.saveInBackgroundWithBlock({(NSError error) in
                if (error != nil){
                    // 端末情報の登録に失敗した時の処理
                }else{
                    // 端末情報の登録に成功した時の処理
                }
            })
        }