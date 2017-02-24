//
//  WTKViewModelNvigationImpl.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/13.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKViewModelNvigationImpl: NSObject,WTKViewModelServicesType {
    weak var vc : UINavigationController?

    func pushViewModel(viewModel: WTKBasedVM, animated: Bool) {
        let vc = WTKRouter.shareInstance.viewControllerOfViewModel(viewModel: viewModel)
//        print(self.vc)
        self.vc?.pushViewController(vc, animated: animated)
        
        
    }
    
    func popViewModelWithAnimated(animated: Bool) {
       _ = vc?.popViewController(animated: animated)
        
    }
    
    func popToRootViewModelWithAniamted(animated: Bool) {
       _ = vc?.popToRootViewController(animated: animated)
    }
    
    func presentViewModel(viewModel: WTKBasedVM, animated flag: Bool, complete page: (() -> Void)) {}
    
    func dismissViewModelWithAnimated(flag: Bool, complete page: (() -> Void)) {}
}
