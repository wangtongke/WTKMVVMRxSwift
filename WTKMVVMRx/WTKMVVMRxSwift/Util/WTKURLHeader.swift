//
//  WTKURLHeader.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/20.
//  Copyright © 2017年 王同科. All rights reserved.
//

import Foundation

let BASED_URL = "http://api.dantangapp.com/\(WTKUser.shareInstance.sex == true ? "v1" : "v2")"

//首页类别
let HomeBasedData = "/channels/preset"

//首页
let HomeURL = "/channels/4/items"

// 单品
let Product = "/items"

