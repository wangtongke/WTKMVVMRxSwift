//
//  WTKHomeVM.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/12.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class WTKHomeVM: WTKBasedVM {
    var test : Int = 2
    
    var basedCommand : PublishSubject<AnyObject>!
    
    var refreshCommand : Observable<AnyObject>!
    
    var channelArray = NSMutableArray()
    
    var basedData : PublishSubject<NSMutableArray>!
    
    
    required init(services service: WTKViewModelServicesType, params param: [String : AnyObject]) {
        super.init(services: service, params: param)
        configViewModel()
    }
    
    func configViewModel(){
        let ws = weakSelf(weakSelf: self) as! WTKHomeVM
        
        basedCommand = PublishSubject<AnyObject>()
        basedData = PublishSubject<NSMutableArray>()
        basedCommand.asObservable().subscribe { (event) in
//            
            if event.element as! Int != 1{
                return
            }
            let param : NSDictionary = ["gender" : WTKUser.shareInstance.sex == true ? "1" : "2","generation" : WTKUser.shareInstance.generation]
            WTKRequestManager.postWithURL(url: HomeBasedData, param: param).subscribe({ (e) in
                let x = e.element! as! NSDictionary
                let code = x["code"] as! Int
                if code == 200
                {
                    guard let data = x["data"]  else {
                        return
                    }
                    let channel = (data as! NSDictionary )["channels"] as! NSArray
                    let mArray = NSMutableArray()
                    for dic in channel
                    {
                        let obj = WTKChannel.init(aDic: dic as! NSDictionary)
                        mArray.add(obj)
                    }
                    ws.channelArray = mArray
                    ws.basedData.onNext(mArray)
                }
            }).addDisposableTo(ws.myDisposeBag)
        }.addDisposableTo(myDisposeBag)

        basedCommand.onNext(1 as AnyObject)
        
        self.refreshCommand = Observable.create({ (x) -> Disposable in
            
            return Disposables.create()
        })
    }
}

//http://api.dantangapp.com/v2/channels/14/items?gender=1&generation=1&limit=20&offset=0


///// 精选
//case Selection = 4
///// 美食
//case Food = 14
///// 家居
//case Household = 16
///// 数码
//case Digital = 17
///// 美物
//case GoodThing = 13
///// 杂货
//case Grocery = 22
