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
    /**
     * 更换ImageView图片
     * param ： imgView   UIImageView
     * param : name     图片名
     */
    static func changeImageWithImgView(imgView : UIImageView, name: String) {
        let size = imgView.frame.size
        UIView.animate(withDuration: 0.1, animations: {
            imgView.bounds = CGRect.init(x: 0, y: 0, width: size.width / 3.0 , height: size.height / 3.0)
        }) { (x) in
            imgView.image = UIImage.init(named: name)
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.1,
                           options: .curveLinear,
                           animations: {
                imgView.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            },
                           completion: { (x) in
                
            })
            
            
            
            
//            usingSpringWithDamping:1.0
//            initialSpringVelocity:0.1
//            options:UIViewAnimationOptionCurveLinear
        }
    }
    
    static func changImageOfLayout(imgView : UIImageView, name : String) {
        let size = imgView.frame.size
        UIView.animate(withDuration: 0.2, animations: {
            imgView.snp.updateConstraints({ (make) in
                make.size.equalTo(CGSize.init(width: size.width / 2.0, height: size.height / 2.0))
            })
        }) { (x) in
            imgView.image = UIImage.init(named: name)
//            UIView.animate(withDuration: 0.35,
//                           delay: 0,
//                           usingSpringWithDamping: 0.4,
//                           initialSpringVelocity: 0.1,
//                           options: .curveLinear,
//                           animations: {
//                            
//            },
//                           completion: { (x) in
//                            
//            })
    }
    }
    
    /**
     * 分享
     */
    static func shared() {
        
    }
    
}


extension UIImageView {
    
}






