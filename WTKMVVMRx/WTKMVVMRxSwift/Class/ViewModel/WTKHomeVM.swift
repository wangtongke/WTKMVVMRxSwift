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
    
    var refreshCommand : PublishSubject<[Int : WTKChannel]>!
    
    var selectedChannelCommand : PublishSubject<[Int : WTKChannel]>!
    
    var basedData : PublishSubject<NSMutableArray>!
    
    ///data
    var dataDic = NSMutableDictionary()
    
    var putDetaileData : Variable<NSArray>!
    
    
    required init(services service: WTKViewModelServicesType, params param: [String : AnyObject]) {
        super.init(services: service, params: param)
        configViewModel()
    }
    
    func configViewModel(){
        let ws = weakSelf(weakSelf: self) as! WTKHomeVM
        putDetaileData = Variable.init([])
        basedCommand = PublishSubject<AnyObject>()
        basedData = PublishSubject<NSMutableArray>()
        basedCommand.asObservable().subscribe { (event) in
//            
            if event.element as! Int != 1{
                return
            }
            let param : NSDictionary = ["gender" : WTKUser.shareInstance.sex == true ? "1" : "2","generation" : WTKUser.shareInstance.generation]
            WTKRequestManager.getWithURL(url: HomeBasedData, param: param).subscribe({ (e) in
                let x = e.element! as! NSDictionary
                let code = x["code"] as! Int
                if code == 200
                {
                    guard let data = x["data"]  else {
                        return
                    }
                    wPrint(message: data)
                    let channel = (data as! NSDictionary )["channels"] as! NSArray
                    let mArray = NSMutableArray()
                    for dic in channel
                    {
                        let obj = WTKChannel.init(aDic: dic as! NSDictionary)
                        mArray.add(obj)
                    }
                    ws.basedData.onNext(mArray)
                    
                }
            }).addDisposableTo(ws.myDisposeBag)
        }.addDisposableTo(myDisposeBag)

        basedCommand.onNext(1 as AnyObject)
        
        self.refreshCommand = PublishSubject<[Int : WTKChannel]>()
        
        self.refreshCommand.subscribe { [unowned self](event) in
            let xr = event.element!
            
//            gender=1&generation=1&limit=20&offset=0
            let param = ["gender" : WTKUser.shareInstance.sex == true ? 1 : 2, "generation" : WTKUser.shareInstance.generation,"limit" : 20, "offset" : 0] as NSDictionary
            let url = "/channels/\(xr.values.first!.id!)/items"
            WTKRequestManager.getWithURL(url: url, param: param).subscribe({ (e) in
                let x = e.element as! NSDictionary
                if x["code"] as! Int == 200
                {
                    let array = (x["data"]as! NSDictionary)["items"]! as! NSArray
                    let mArray = NSMutableArray()
                    for dic in array
                    {
                        wPrint(message: dic)
                        let model = WTKHomeModel.init(aDic: dic as! NSDictionary)
                        mArray.add(model)
                    }
                    self.dataDic[xr.keys.first] = mArray
                    ws.putDetaileData.value = mArray
                }
            }).addDisposableTo(self.myDisposeBag)
            
        }.addDisposableTo(myDisposeBag)
        
        self.selectedChannelCommand = PublishSubject<[Int : WTKChannel]>()
        self.selectedChannelCommand.subscribe { [unowned self](event) in
            let x = event.element!
            let data = self.dataDic[x.keys.first!]
            if data == nil {
                //                无此数据执行刷新
                wPrint(message: x.keys.first!)
                wPrint(message: self.dataDic)
                self.refreshCommand.onNext(x)
            } else {
                self.putDetaileData.value = data as! NSArray
            }

            
        }.addDisposableTo(myDisposeBag)
        
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
