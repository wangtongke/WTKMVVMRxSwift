//
//  WTKTools.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/8.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

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
     * 回调  1 ： qq好友，   2：微信好友  3 ： 新浪    4 ：微信  5 ： 短信   6：复制 
     */
    static func shared() -> PublishSubject<Int> {
        
        let clickCommand : PublishSubject<Int> = PublishSubject<Int>()
        
        let window : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let blurView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight))
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight))
        imgView.image = self.imageWithView(view: window, withBlurRadiu: 15)
        blurView.addSubview(imgView)
        window.addSubview(blurView)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(WTKTools.disMissSharView(gesture:)))
        blurView.addGestureRecognizer(tapGesture)
        
        let imgArray : NSArray = ["w_share_qq","w_share_wechat","w_share_sina","w_share_wechat","w_share_sina","w_link"]
        let nameArray = ["qq好友","微信好友","新浪","微信好友","新浪","短信"]
        
        let width = kWidth / 5.0
        let height = width  + 30
        let colMargin = kHeight / 2.0 - width
        
        imgArray.enumerateObjects({ (obj, idx, stop) in
            let row = CGFloat(idx / 3)
            let col = CGFloat(idx % 3)
            let btn = WTKShareBtn.button
            btn.frame = CGRect.init(x: 0.5 * width + col * (width + width * 0.5), y: row * (height + width * 0.3) + kHeight, width: width, height: height)
            btn.w_imageView?.image = UIImage.init(named: imgArray[idx] as! String)
            btn.w_label?.text = nameArray[idx]
            btn.tag = idx + 100
            blurView.addSubview(btn)
            _ = btn.rx.tap.subscribe({ (event) in
                clickCommand.onNext(btn.tag)
                print(btn.tag)
            })
            
            UIView.animate(withDuration: 1.0 + 0.1 * Double(idx),
                           delay: 0,
                           usingSpringWithDamping: 0.57,
                           initialSpringVelocity: 1,
                           options: .curveEaseInOut,
                           animations: {
                            btn.frame = CGRect.init(x: btn.frame.origin.x, y: btn.frame.origin.y - kHeight + colMargin, width: width, height: height)
            },
                           completion: {(x) in
                
            })
        })
        
        let textView = UIImageView.init(frame: CGRect.init(x: (kWidth - 300) / 2.0, y: colMargin - 131 - 30 - kHeight, width: 300, height: 131))
        textView.image = UIImage.init(named: "shareText")
        textView.tag = 200
        blurView.addSubview(textView)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: {
                            textView.frame = CGRect.init(x: (kWidth - 300) / 2.0, y: colMargin - 131 - 30, width: 300, height: 131)
        },
                       completion: nil)
        
        
        return clickCommand
    }
    
    static func imageWithView(view : UIView, withBlurRadiu radiu : CGFloat) -> UIImage {
        var img : UIImage
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        for subView : UIView in view.subviews {
            subView.drawHierarchy(in: subView.bounds, afterScreenUpdates: true)
        }
        img = UIGraphicsGetImageFromCurrentImageContext()!
        img = img.applyBlur(withRadius: radiu, tintColor: UIColor.init(white: 0.8, alpha: 0.2), saturationDeltaFactor: 1.8, maskImage: nil)
        return img
    }
    
     static func disMissSharView(gesture : UITapGestureRecognizer) {
        let textView = gesture.view?.viewWithTag(200)
        UIView.animate(withDuration: 0.3) { 
            textView?.frame = CGRect.init(x: (kWidth - 300) / 2.0, y: -31 - 30, width: 300, height: 131)
        }
        
        for i in 0...5 {
            let view = gesture.view?.viewWithTag(100 + i)
            UIView.animate(withDuration: 0.4 - 0.03 * Double(i), animations: { 
                view?.frame = CGRect.init(x: (view?.frame.origin.x)!, y: (view?.frame.origin.y)! + kHeight, width: (view?.frame.width)!, height: (view?.frame.height)!)
            }, completion: { (x) in
                view?.removeFromSuperview()
                if i == 5 {
                    gesture.view?.removeFromSuperview()
                }
            })
        }
    }
    
}


extension UIImageView {
    
}






