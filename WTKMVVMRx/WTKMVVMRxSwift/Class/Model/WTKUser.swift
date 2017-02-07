//
//  WTKUser.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/23.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKUser: NSObject {

    var role : WTKRole!
    
    /// true - boy  false - girl
    var sex : Bool!
    
    var generation : String{
        get{
            let type : WTKRole = WTKUser.shareInstance.role
            switch type {
            case WTKRole.minType:
                return "0"
            case .midType:
                return "1"
            case .maxType:
                return "2"
            case .newType:
                return "3"
            case .oldType:
                return "4"
            }
        }
    }
    
    
//    MARK: share Instance
    static var shareInstance : WTKUser {
        let user = WTKUser.init()
        user.role = WTKRole.newType
        user.sex = true
        return user
    }
    
    
    enum WTKRole : Int {
        
        case minType
        
        case midType
        
        case maxType
        
        case newType
        
        case oldType
    }
    
    
}
    

