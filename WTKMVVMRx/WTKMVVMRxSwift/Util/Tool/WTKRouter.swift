//
//  WTKRouter.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/10.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKRouter: NSObject {

    static var shareInstance : WTKRouter {
        let obj = WTKRouter.init()
        return obj
    }
    
    func viewControllerOfViewModel(viewModel : WTKBasedVM) ->WTKBasedVC {

        let vcString = map[NSStringFromClass(viewModel.classForCoder).components(separatedBy: ".").last!]!
        let vcClass = NSClassFromString("WTKMVVMRxSwift.\(vcString)") as! WTKBasedVC.Type
        
        let vc = vcClass.init(viewModel: viewModel)
        
        return vc
        
    }
    
    private override init() {}
    
    private var map : [String: String] {
        return ["WTKHomeVM":"WTKHomeVC",
                "WTKProductVM":"WTKProductVC",
                "WTKCategoryVM":"WTKCategoryVC",
                "WTKMeVM" : "WTKMeVC",
                "WTKWebVM":"WTKWebVC",
                "WTKStrategyDetaileVM" : "WTKStrategyDetaileVC"]
    }
}
