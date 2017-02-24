//
//  WTKHomeModel.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/7.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKHomeModel: NSObject {

    var content_url : String!
    var cover_image_url : String!
    var created_at : String!
    var editor_id : String!
    var id : String!
    var liked : String!
    var likes_count : String!
    var published_at : String!
    var share_msg : String!
    var short_title : String!
    var status : String!
    var template : String!
    var title : String!
    var type : String!
    var updated_at : String!
    var url : String!
    
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
