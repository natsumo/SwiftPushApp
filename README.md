# Swiftアプリにプッシュ通知を組み込もう！
ハンズオンセミナー【Swiftアプリにプッシュ通知を組み込もう！】のコーディング時に使用するコピペ用ページです

* 別に配布の資料のページと一致する部分のコードのみ記載しています。
* 詳しい進め方等は資料をご覧ください。

## P18～P20 ターミナル
※`$`マークを覗いてコピー＆ペーストします

* ディレクトリの移動

`$ cd[ディレクトリ]`

* ディレクトリ内のファイル・フォルダの表示

`$ ls`

* 【はじめて使う場合】CocoaPodsのインストール

`$ sudogem install cocoapods`

* 【既にCocoaPodsインストールしている場合】CocoaPodsのバージョンアップ

`$ sudogem update --system`

* セットアップ

`$ pod setup`

* バージョン確認

`$ pod --version`

* Podfileの作成

`$ pod init`


## P21 Podfile

```ruby
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'SwiftPushApp' do
    pod 'NCMB', :git => 'https://github.com/NIFTYCloud-mbaas/ncmb_ios.git'
end
```


## P22 ターミナル
 
* Podfileの内容をインストール
`$ pod install`

## P23 AppDelegate.swift

```swift
import NCMB
```

## P25 AppDelegate.swift

```swift
//********** APIキーの設定**********
let applicationkey = "YOUR_NCMB_APPLICATIONKEY"
let clientkey = "YOUR_NCMB_CLIENTKEY"
```

※「YOUR_NCMB_APPLICATIONKEY」と「YOUR_NCMB_CLIENTKEY」は各々のmBaaSダッシュボードからコピペしてください。

## P26 AppDelegate.swift

```swift
//********** SDKの初期化**********
NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
```

## P28 AppDelegate.swift

```swift
if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
    /** iOS8以上での、DeviceToken要求方法**/
    // 通知のタイプを設定したsettingを用意
    let type : UIUserNotificationType = [.Alert, .Badge, .Sound]
    let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
    // 通知のタイプを設定
    application.registerUserNotificationSettings(setting)
    application.registerForRemoteNotifications()
}else{
    //** iOS8未満での、DeviceToken要求方法**/
    let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
    // 通知のタイプを設定
    UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
}
```

## P29 AppDelegate.swift

```swift
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
```
