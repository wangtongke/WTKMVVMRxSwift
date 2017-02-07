//
//  WTKViewModelServices.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/13.
//  Copyright © 2017年 王同科. All rights reserved.
//

import Foundation

protocol WTKViewModelServicesType {
    func pushViewModel(viewModel : WTKBasedVM , animated : Bool) -> Void
    
    func popViewModelWithAnimated(animated : Bool) ->Void
    
    func popToRootViewModelWithAniamted(animated : Bool) ->Void
    
    func presentViewModel(viewModel : WTKBasedVM, animated flag : Bool, complete page : (() -> Void)) -> Void
    
    func dismissViewModelWithAnimated(flag : Bool, complete page : (() -> Void))
}
