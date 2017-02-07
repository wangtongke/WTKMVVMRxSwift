//
//  WTKHeader.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/18.
//  Copyright © 2017年 王同科. All rights reserved.
//

import Foundation
import UIKit


//TODO: 宽高
let kWidth = UIScreen.main.bounds.width

let kHeight = UIScreen.main.bounds.height

let kScallWidth = UIScreen.main.bounds.width / 375.0

let kScallHeight = UIScreen.main.bounds.height / 667.0

//MARK : VERSION
let SYSTEM_VERSION = UIDevice.current.systemVersion

//user default
let USER_DEFAULT = UserDefaults.standard


//常用颜色
let THEME_COLOR = WTKColor(r: 231,g: 84,b: 83,a: 1)

let BACK_COLOR = WTKColor(r: 240,g: 240,b: 240,a: 1)

let BLACK_COLOR = WTKColor(r: 50,g: 50,b: 50,a: 1)

let LINE_COLOR = WTKColor(r: 220,g: 220,b: 220,a:1)

let WORD_COLOR = WTKColor(r: 80,g: 80,b: 80,a: 1)


//MARK: 字符串
let kIsRefresh = "isRefresh"


//TODO: FUNC

//RGB
func WTKColor(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
func wPrintDetail<N>(message: N, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){

    #if DEBUG // 若是Debug模式下，则打印

            print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
  #endif
}
func wPrint<N>(message: N, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    
    #if DEBUG // 若是Debug模式下，则打印
        
        print(message);
    #endif
}

/// 常规字体
func wSystemFont(size: CGFloat) -> UIFont {
    if kWidth == 320 || kWidth == 640 {
        return UIFont.systemFont(ofSize: size)
    } else if kWidth == 375 || kWidth == 750 {
        return UIFont.systemFont(ofSize: size + 0.75)
    } else {
        return UIFont.systemFont(ofSize: size + 1.5)
    }
}

func wBlodFont(size: CGFloat) -> UIFont {
    if kWidth == 320 || kWidth == 640 {
        return UIFont.boldSystemFont(ofSize: size)
    } else if kWidth == 375 || kWidth == 750 {
        return UIFont.boldSystemFont(ofSize: size + 0.75)
    } else {
        return UIFont.boldSystemFont(ofSize: size + 1.5)
    }
}


// MARK - 弱引用
func weakSelf(weakSelf : AnyObject) -> AnyObject{
    weak var ws = weakSelf
    return ws!
}
