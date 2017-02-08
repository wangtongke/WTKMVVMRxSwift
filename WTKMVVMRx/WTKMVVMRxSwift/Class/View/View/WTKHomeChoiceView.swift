//
//  WTKHomeChoiceView.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/20.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import SnapKit

class WTKHomeChoiceView: UIView {

//    MARK: property
    var data : [WTKChannel]!{
        didSet{
            reloadDataSource()
        }
    }
    var lastIndex : Int {
        didSet{
            if self.btnArray.count - 1 > lastIndex {
                btnClick(sender: self.btnArray[lastIndex] as! UIButton)
            }
        }
    }
    var scrollView = UIScrollView()
    var bottomLine = UIView()
    var btnArray = NSMutableArray()
    
    var pullBtn = UIButton.init(type: UIButtonType.custom)

    ///btn点击回调
    var selectedBlock : (Int ,WTKChannel)->() = {
        name,channel in
    }
    
//    MARK: init
    init(title : [WTKChannel], frame : CGRect) {
        lastIndex = 0
//        selectedBlock = nil
        super.init(frame: frame)
        data = title
        bottomView()
        initView()
        
    }
    
    func rigthView() {
        
    }
    
    func bottomView(){
        bottomLine.backgroundColor = THEME_COLOR
        scrollView.addSubview(bottomLine)
    }
    
    func initView(){

        let width = kWidth / 6.0
        let height = self.frame.height
        scrollView.frame = CGRect.init(x: 0, y: 0, width: width * 5, height: self.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: width * CGFloat(data.count), height: height)
        self.addSubview(scrollView)
        
        if data.count == 0 {
            return
        }
        for i in 0...data.count - 1 {
            let title = data[i]
            if btnArray.count - 1 < i {
                let btn = UIButton.init(type: .custom)
                btn.setTitleColor(WORD_COLOR, for: .normal)
                btn.setTitleColor(THEME_COLOR, for: .selected)
                btn.titleLabel?.textAlignment = NSTextAlignment.center
                btn.titleLabel?.font = wSystemFont(size: 14)
                btnArray.add(btn)
            }
            let btn = btnArray[i] as! UIButton
            btn.setTitle(title.name, for: UIControlState.normal)
            btn.frame = CGRect.init(x: width * CGFloat(i), y: 0, width: width, height: self.frame.height)
            btn.tag = i
            btn.addTarget(self, action: #selector(WTKHomeChoiceView.btnClick(sender:)), for: .touchUpInside)
            scrollView.addSubview(btn)
            if i == 0 {
                btnClick(sender: btn)
                bottomLine.frame = CGRect.init(x: width / 6.0, y: height - 3, width: width * 2.0 / 3.0, height: 2)
                scrollView.bringSubview(toFront: bottomLine)
            }
        }
        
    }
    func updateWithIndex(tag: Int){
        guard let currentBtn = btnArray[tag] as? UIButton else {
            return
        }
        btnClick(sender: currentBtn)
    }
    
    func btnClick(sender : UIButton) {
        wPrint(message: sender.tag)
        guard let lastBtn = btnArray[lastIndex] as? UIButton else {
            return
        }
        lastBtn.isSelected = !lastBtn.isSelected
        sender.isSelected = true
        if lastIndex == sender.tag {
            return
        }
        lastIndex = sender.tag
        
//        line
        let width = kWidth / 6.0
        let height = self.frame.height
        UIView.animate(withDuration: 0.3) { [unowned self] in
           self.bottomLine.frame = CGRect.init(x: width / 6.0 + CGFloat(sender.tag) * width, y: height - 3, width: width * 2.0 / 3.0, height: 2)
        }
        reloadScrollView()
//      回调
        selectedBlock(sender.tag, data[sender.tag])
        
    }
    ///更新数据源
    func reloadDataSource() {
        initView()
    }
    
    ///滑动
    func reloadScrollView() {
        if lastIndex > 1 && lastIndex < data.count - 2 {
//            当前选择滚到到中间
            let width = kWidth / 6.0
            scrollView.setContentOffset(CGPoint.init(x: width * CGFloat(lastIndex - 2), y: 0), animated: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
