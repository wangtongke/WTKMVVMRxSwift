//
//  WTKRequestManager.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/20.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire

class WTKRequestManager: NSObject {

    static func getWithURL(url: String, param : NSDictionary) -> Observable<AnyObject> {
        let urlTmp = "\(BASED_URL)\(url)"
        return Observable.create({ (x) -> Disposable in
//            x.onNext(["wang":"hehe"])
            
            Alamofire.request(urlTmp, method: .get, parameters: param as? Parameters).responseJSON {
                response in
                
                guard let JSON = response.result.value else {
                    x.onNext(["code":-100, "msg":"好像网络出问题了哦~~"] as AnyObject)
                    return
                }
                
                x.onNext(JSON as AnyObject)
                
            }
//            Alamofire.request(urlTmp!, method: .get, parameters: param as! Parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
//                guard let
//            })
            return Disposables.create()
            
            
        })
    }
    
}
