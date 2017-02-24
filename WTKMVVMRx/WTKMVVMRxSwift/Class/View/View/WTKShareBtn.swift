//
//  WTKShareBtn.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/17.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKShareBtn: UIButton {

    var w_imageView : UIImageView?
    var w_label : UILabel?
    
    /**
     *  分享button  上面图片 下面文字
     */
    static var button : WTKShareBtn {
        return WTKShareBtn.init(type: .custom)
    }
    /**
     *  图片为正方形 下面文字  间隔5
     */
    override var frame: CGRect {
        didSet {
            if self.w_imageView != nil {
                return
            }
            self.w_imageView = UIImageView()
            self.addSubview(self.w_imageView!)
            w_imageView?.snp.makeConstraints({ [unowned self] (make) in
                make.left.equalTo(self)
                make.right.equalTo(self)
                make.top.equalTo(self)
                make.height.equalTo(self.snp.width)
            })
            
            self.w_label = UILabel.init()
            self.w_label?.textAlignment = .center
            self.w_label?.textColor = WORD_COLOR
            self.w_label?.font = wSystemFont(size: 13)
            self.addSubview(self.w_label!)
            self.w_label?.snp.makeConstraints({ [unowned self] (make) in
                make.top.equalTo((self.w_imageView?.snp.bottom)!).offset(5)
                make.left.equalTo(self).offset(5)
                make.right.equalTo(self).offset(-5)
                make.bottom.equalTo(self)
            })
            
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
