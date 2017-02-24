//
//  WTKBasedVM.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/11.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional

class WTKBasedVM: NSObject {

    let title : String
    var services : WTKViewModelNvigationImpl!
    var ttt : Observable<String>
    var myDisposeBag = DisposeBag()
    
    required init(services service : WTKViewModelNvigationImpl, params param: [String : AnyObject])
   {
        self.title = param["title"]! as! String
        let a = UITextView()
        self.services = service
        self.ttt = a.rx.text.orEmpty.asObservable()
    }

    override var description: String {
        return "wang - \(self.title)"
    }
    
    
}
