//
//  WTKViewModelNvigationImpl.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/13.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKViewModelNvigationImpl: NSObject,WTKViewModelServicesType {
    func pushViewModel(viewModel: WTKBasedVM, animated: Bool) {}
    
    func popViewModelWithAnimated(animated: Bool) {}
    
    func popToRootViewModelWithAniamted(animated: Bool) {}
    
    func presentViewModel(viewModel: WTKBasedVM, animated flag: Bool, complete page: (() -> Void)) {}
    
    func dismissViewModelWithAnimated(flag: Bool, complete page: (() -> Void)) {}
}
