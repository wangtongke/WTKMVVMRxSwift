//
//  WTKSearchVM.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/28.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKSearchVM: WTKBasedVM {

    required init(services service: WTKViewModelNvigationImpl, params param: [String : AnyObject]) {
        super.init(services: service, params: param)
        configViewModel()
    }
    
    
    func configViewModel(){
        print("123")
    }
    
}
