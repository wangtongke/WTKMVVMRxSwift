//
//  WTKTableVM.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/19.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKTableVM: WTKBasedVM {
    var shouldReresh = false
    
    
    
    required init(services service: WTKViewModelNvigationImpl, params param: [String : AnyObject]) {
        super.init(services: service, params: param)
        do {
            try self.shouldReresh = param[kIsRefresh] as! Bool
        } catch  {
            wPrint(message: "tableError")
        }
    }
}
