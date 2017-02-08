//
//  WTKTools.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/8.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKTools: NSObject {
    
    /**
     * 计算文字宽度
     */
    static func calculateStringWidth(text : String, stringFont font : CGFloat) -> CGFloat {
        let ocText = NSString.init(string: text)
        let rect = ocText.boundingRect(with: CGSize(), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : wSystemFont(size: font)], context: nil)
        
        return rect.width
    }
}
