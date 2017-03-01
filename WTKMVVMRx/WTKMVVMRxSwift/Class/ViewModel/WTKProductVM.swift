//
//  WTKProductVM.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/12.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class WTKProductVM: WTKBasedVM {
    
    var refreshCommand : PublishSubject<UICollectionView>!
    
    private var offset = 0
    
    required init(services service: WTKViewModelNvigationImpl, params param: [String : AnyObject]) {
        super.init(services: service, params: param)
        configViewModel()
    }
    
    
    
    func configViewModel() {
        refreshCommand = PublishSubject<UICollectionView>()
//        gender=1&generation=1&limit=20&offset=0
        refreshCommand.subscribe { [unowned self] (event) in
            let x = event.element
            let param = ["gender" : WTKUser.shareInstance.sex == true ? "1" : "2", "generation" : WTKUser.shareInstance.generation, "limit" : 20, "offset" : self.offset] as [String : Any]
            WTKRequestManager.getWithURL(url: Product, param: param as NSDictionary).subscribe({ (requestData) in
                wPrint(message: requestData)
            }).addDisposableTo(self.myDisposeBag)
        }.addDisposableTo(myDisposeBag)
    }
}
