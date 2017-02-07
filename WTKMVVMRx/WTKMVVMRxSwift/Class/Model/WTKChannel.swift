//
//  WTKChannel.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/6.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
/// 首页通道
class WTKChannel: WTKBasedModel {
    var editable : String!
    var id : String!
    var name : String!
    
    init(aDic : NSDictionary) {
        super.init()
        for (key,value) in aDic {
            self.setValue("\(value)", forKey: key as! String)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        wPrint(message: key)
    }
}
