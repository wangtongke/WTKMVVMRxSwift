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
        
        shareCommand.subscribe { (event) in
//            分享
        }.addDisposableTo(myDisposeBag)
    }
}
