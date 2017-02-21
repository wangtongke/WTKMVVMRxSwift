//
//  WTKStrategyDetaileVM.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/10.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class WTKStrategyDetaileVM: WTKBasedVM {
    
    var model : WTKHomeModel!

    var starCommand : PublishSubject<UIButton>!
    
    var shareCommand : PublishSubject<UIButton>!
    
    required init(services service: WTKViewModelNvigationImpl, params param: [String : AnyObject]) {
        super.init(services: service, params: param)
        configViewModel()
    }
    
    func configViewModel() {
        starCommand = PublishSubject<UIButton>()
        shareCommand = PublishSubject<UIButton>()
        
        starCommand.subscribe { (event) in
            
        }.addDisposableTo(myDisposeBag)
        
        shareCommand.subscribe {[unowned self] (event) in
//            分享
            WTKTools.shared().subscribe({ (event) in
                let x = event.element!
                let param : NSMutableDictionary = NSMutableDictionary()
                switch x {
                case 100 :
//                    QQ好友
                    
//                    param.ssdkSetupQQParams(byText: "分享", title: "分享", url: URL.init(string: "http://www.jianshu.com/u/f3e780fd1a4e"), audioFlash: nil, videoFlash: nil, thumbImage: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!thumb", images: ["http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!avatar"], type: SSDKContentType.image, forPlatformSubType: SSDKPlatformType.subTypeQQFriend)
//                    param.ssdkSetupQQParams(byText: "222", title: "111", url: URL.init(string: "http://www.jianshu.com/u/f3e780fd1a4e"), thumbImage: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!thumb", image: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!avatar", type: SSDKContentType.image, forPlatformSubType: SSDKPlatformType.subTypeQQFriend)
                    
                    param.ssdkSetupQQParams(byText: "这是一个分享", title: "分享", url: URL.init(string: "http://www.jianshu.com/u/f3e780fd1a4e"), thumbImage: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!thumb", image: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!avatar", type: SSDKContentType.auto, forPlatformSubType: SSDKPlatformType.subTypeQQFriend)
                    
                    ShareSDK.share(SSDKPlatformType.subTypeQQFriend, parameters: param, onStateChanged: { (state, x, entity, error) in
                        print(error)
                    })
                    break
                case 101 :
                    param.ssdkSetupWeChatParams(byText: "这是一个分享", title: "分享", url:URL.init(string: "http://www.jianshu.com/u/f3e780fd1a4e") , thumbImage: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!thumb", image: "http://img.51xiaoniu.cn/product/main_assets/assets/573e/6d28/206a/af4e/87f2/b739/573dc0e1af48433144e07ae5.jpg@!avatar", musicFileURL: nil, extInfo: nil, fileData: nil, emoticonData: nil, type: SSDKContentType.auto, forPlatformSubType: SSDKPlatformType.subTypeWechatSession)
                    ShareSDK.share(SSDKPlatformType.subTypeWechatSession, parameters: param, onStateChanged: { (x, y, z, error) in
                        print(error)
                    })
                    break
                    
                default :
                    break
                }
            }).addDisposableTo(self.myDisposeBag)
        }.addDisposableTo(myDisposeBag)
    }
}
