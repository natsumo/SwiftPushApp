# 【iOS Swift】アプリにプッシュ通知を組み込もう！

![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の『プッシュ通知』機能を実装したサンプルプロジェクトです
* 簡単な操作ですぐに [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます★☆

## ニフティクラウドmobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.10(Yosemite)
* Xcode ver. 7.2.1
* iPhone6 ver. 8.2
 * このサンプルアプリは、実機ビルドが必要です
* Lightningケーブル

※上記内容で動作確認をしています


## プッシュ通知の仕組み
* ニフティクラウドmobile backendのプッシュ通知は、iOSが提供している通知サービスを利用しています
 * iOSの通知サービス　__APNs（Apple Push Notification Service）__

 ![画像1](/readme-img/001.png)

* 上図のように、アプリ（Xcode）・サーバー（ニフティクラウドmobile backend）・通知サービス（APNs）の間でやり取りを行うため、認証が必要になります
 * 認証に必要な鍵や証明書の作成は作業手順の「0.プッシュ通知機能使うための準備」で行います

## 作業の手順
### 0.プッシュ通知機能使うための準備
* 準備作業が少し複雑です
 * 作り方を誤ると動作しない可能性があります
 * 丁寧に作業していきましょう！
* 下図の内容を作成していきます

![画像i2](/readme-img/i002.png)

* 作成したファイルはダウンロードし、同じフォルダにまとめておきましょう

* ①CSRファイルを作成します　※初回利用時のみ
 * __注意__：CSRファイルは既に作成したものがあれば、新しく作成しなください！必ず既存のものを使用します。複数作成してしまうとファイル名が同じであるため区別できなくなり失敗につながる恐れがあります。
* 「キーチェーンアクセス」を開いて、メニューバーの「キーチェーンアクセス」＞「証明書アシスタント」＞をクリックします

![画像i3](/readme-img/i003.png)

* 「鍵ペア情報」を確認して「続ける」をクリックし、「設定結果」が出るので「完了」をクリックします
* 保存場所を選択して「保存」をクリックします

![画像i4](/readme-img/i004.png)

* ここから[Apple Developer Programのメンバーセンター](https://developer.apple.com/account/)にログインして作業を行います

![画像i5](/readme-img/i005.png)

* ②開発用証明書(.cer)を作成します　※初回利用時のみ
 * __注意__：開発用証明書(.cer)ファイルは既に作成したものがあれば、新しく作成しないでください！必ず既存のものを使用します。複数作成してしまうとファイル名が同じであるため区別できなくなり失敗につながる恐れがあります。
* 「Certificates」＞「All」＞右上の「＋」をクリックして、「iOS App Development」にチェックをいれます
 
![画像i6](/readme-img/i006.png)
![画像i7](/readme-img/i007.png)
![画像i8](/readme-img/i008.png)

* ③AppIDを作成します
* 「Identifiers」＞「App IDs」＞右上の「＋」をクリックします

![画像i9](/readme-img/i009.png)
![画像i10](/readme-img/i010.png)
![画像i11](/readme-img/i011.png)
![画像i12](/readme-img/i012.png)

* ④動作確認で使用する端末の登録をします
 * 既に登録済みの場合、この作業は不要です
* 「Devices」＞「All」＞右上の「＋」をクリックします

![画像i13](/readme-img/i013.png)

* UDIDは下記のいずれかの方法で調べることができます

![画像i14](/readme-img/i014.png)
![画像i15](/readme-img/i015.png)

* 先ほどの入力欄に調べたUDIDをコピーして貼り付け、「Continue」をクリックします

![画像i16](/readme-img/i016.png)

* ⑤プロビジョニングプロファイルを作成します
* 「Provisioning Profiles」＞「All」＞右上の「＋」をクリックします

![画像i17](/readme-img/i017.png)
![画像i18](/readme-img/i018.png)
![画像i19](/readme-img/i019.png)
![画像i20](/readme-img/i020.png)

* ⑥APNs用証明書(.cer)の作成をします
* 「Certificates」＞「All」＞右上の「＋」をクリックします

![画像i21](/readme-img/i021.png)
![画像i22](/readme-img/i022.png)

* CSRファイルは①開発用証明書(.cer)作成時と同じものを使用します

![画像i23](/readme-img/i023.png)
![画像i24](/readme-img/i024.png)

* ⑦APNs用証明書(.p12)を書き出します
* キーチェーンアクセスを開きます
* ⑥で作成した「APNs用証明書(.cer)」をダブルクリックしてキーチェーンアクセスを開きます
* 三角のアイコンをクリックして、開きます
 * 重要：証明書と秘密鍵を別々にする必要があります！ 

![画像i27](/readme-img/i027.png)
![画像i28](/readme-img/i028.png)

* この後使用する証明書やファイルを確認しておきましょう
 * ②開発用証明書(.cer)・⑤プロビジョニングプロファイル・⑦APNs用証明書(.p12)

### 1. [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の会員登録とログイン→アプリ作成と設定
* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* 続けてプッシュ通知の設定を行います
* ここで⑦APNs用証明書(.p12)の設定も行います

![画像5](/readme-img/005.png)

### 2. [GitHub](https://github.com/natsumo/SwiftPushApp.git)からサンプルプロジェクトのダウンロード

* この画面([GitHub](https://github.com/natsumo/SwiftPushApp.git))の![画像10](/readme-img/010.png)ボタンをクリックし、さらに![画像11](/readme-img/011.PNG)ボタンをクリックしてサンプルプロジェクトをMacにダウンロードします

### 3. Xcodeでアプリを起動

* ダウンロードしたフォルダを開き、![画像09](/readme-img/009.png)をダブルクリックしてXcode開きます　![画像08](/readme-img/008.png)

![画像6](/readme-img/006.png)

### 3. APIキーの設定

* `AppDelegate.swift`を編集します
* 先程[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像07](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 4. 実機ビルド
* 始めて実機ビルドをする場合は、Xcodeにアカウント（AppleID）の登録をします
 * メニューバーの「Xcode」＞「Preferences...」を選択します
 * Accounts画面が開いたら、左下の「＋」をクリックします。
 * Apple IDとPasswordを入力して、「Add」をクリックします
 
 ![図F2.png](https://qiita-image-store.s3.amazonaws.com/0/112032/bef843be-5581-9e0f-aad2-1c05626d9e5d.png)

 * 追加されると、下図のようになります。追加した情報があっていればOKです
 * 確認できたら閉じます。

 ![図F3.png](https://qiita-image-store.s3.amazonaws.com/0/112032/89d9c25c-d4fa-4e93-a454-507c0575f9a3.png)

* プロジェクトをクリックして、「Build Settings」＞「Code Signing」に②開発用証明書(.cer)と⑤プロビジョニングプロファイルを設定します

![画像i25](/readme-img/i025.png)

* 「Code Signing Identity」に②開発用証明書(.cer)を設定しますが、「Provisioning Profile」に作成した⑤プロビジョニングプロファイルを設定すれば、「Code Signing Identity」の部分は「Automatic」で構いません
 * __注意__：作成した⑤プロビジョニングプロファイルは一度ダブルクリックをしておかないと、「Provisioning Profile」に設定できません。
* Bundle ID を設定します
* 「General」＞「Identity」の「Bundle Identifier」に③AppID を作成したときに入力したBundle IDに書き換えてください

![画像i26](/readme-img/i026.png)

* 設定は完了です
* lightningケーブルで④端末の登録で登録した、動作確認用iPhoneをMacにつなぎます
 * 実機ビルドが初めての場合は[こちら](http://qiita.com/natsumo/items/3f1dd0e7f5471bd4b7d9)をご覧いただき、実機ビルドの準備をお願いします
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします
* __ビルド時にエラーが発生した場合の対処方法__
 * Xcodeのバージョンが古い場合`import NCMB`にエラーが発生し、上手くSDKが読み込めないことがあります
 * その場合は[【Swift】SDKの読み込みにuse framework!が使えない場合の対処方法](http://goo.gl/Z1D0K3)をご覧いただき、別の読み込み方法をお試しください

### 5.動作確認
* インストールしたアプリを起動します
 * プッシュ通知の許可を求めるアラートが出たら、必ず許可してください！
* 起動されたらこの時点でデバイストークンが取得されます
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「データストア」＞「installation」クラスを確認してみましょう！

![画像12](/readme-img/012.png)

* 端末側で起動したアプリは一度閉じておきます

### 6.__プッシュ通知を送りましょう！__
* いよいよです！実際にプッシュ通知を送ってみましょう！
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「プッシュ通知」＞「＋新しいプッシュ通知」をクリックします
* プッシュ通知のフォームが開かれます
* 必要な項目を入力してプッシュ通知を作成します

![画像13](/readme-img/013.png)

* 端末を確認しましょう！
* 少し待つとプッシュ通知が届きます！！！

## 解説
サンプルプロジェクトに実装済みの内容のご紹介

#### SDKのインポートと初期設定
* ニフティクラウドmobile backend の[ドキュメント（クイックスタート）](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [SwiftでmBaaSを始めよう！(＜CocoaPods＞でuse_framewoks!を有効にした方法)](http://qiita.com/natsumo/items/57d3a4d9be16b0490965)

#### ロジック
 * `AppDelegate.swift`の`didFinishLaunchingWithOptions`メソッドにAPNsに対してデバイストークンの要求するコードを記述し、デバイストークンが取得された後に呼び出される`didRegisterForRemoteNotificationsWithDeviceToken`メソッドを追記をします
 * デバイストークンの要求はiOSのバージョンによってコードが異なります

```swift
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
        
        // デバイストークンの要求
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
        installation.saveInBackgroundWithBlock({(error: NSError!) -> Void in
            if (error != nil){
                // 端末情報の登録に失敗した時の処理
                
            }else{
                // 端末情報の登録に成功した時の処理
            }
        })
    }
}
```

## 参考
* ニフティクラウドmobile backend の[ドキュメント（プッシュ通知）](http://mb.cloud.nifty.com/doc/current/push/basic_usage_ios.html)をSwift版に書き換えたドキュメントをご用意していますので、ご活用ください
 * [Swiftでプッシュ通知を送ろう！](http://qiita.com/natsumo/items/8ffafee05cb7eb69d815)
* 同じ内容の【Objective-C】版もご用意しています
 * https://github.com/natsumo/ObjcPushApp