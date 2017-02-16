//
//  WTKStrategyDetaileVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/10.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift
/**
 * 攻略详情
 */
class WTKStrategyDetaileVC: WTKBasedVC,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate {
    let progressPath = "estimatedProgress"
    let titlePath = "title"
    var viewModel : WTKStrategyDetaileVM {
        return self.vm as! WTKStrategyDetaileVM
    }
    
    var webView = WKWebView()

    var progressView = UIProgressView()
    
    var headView = UIImageView()
    var titleLabel = UILabel()
    
    /// 头部背景
    var bgView = UIView()
    
//    底部背景
    var bottomView = UIView()
    
    var starBtn = UIButton.init(type: .custom)
    var starImg = UIImageView()
    var shareBtn = UIButton.init(type: .custom)
    var commentBtn = UIButton.init(type: .custom)
    
    
//    MARK : lifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.addObserver(self, forKeyPath: progressPath, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: titlePath, options: .new, context: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.scrollView.delegate = nil
        webView.removeObserver(self, forKeyPath: progressPath)
        webView.removeObserver(self, forKeyPath: titlePath)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        let url = URL.init(string: self.viewModel.model.content_url)
        webView.load(URLRequest.init(url: url!))
        headView.sd_setImage(with: URL.init(string: self.viewModel.model.cover_image_url), placeholderImage: UIImage.init(named: "placehoder1"))
        wPrint(message: self.viewModel.model.cover_image_url)
        titleLabel.text = self.viewModel.model.title
        starBtn.setTitle(self.viewModel.model.likes_count, for: .normal)
        shareBtn.setTitle(self.viewModel.model.id, for: .normal)
        commentBtn.setTitle("12", for: .normal)
        
        starBtn.rx.tap.subscribe({ [unowned self] (event) in
            self.starBtn.isSelected = !self.starBtn.isSelected
            if self.starBtn.isSelected {
                self.starBtn.setTitle("\(Int(self.viewModel.model.likes_count!)! + 1)", for: .normal)
                WTKTools.changeImageWithImgView(imgView: self.starImg, name: "w_star1")
            } else {
                self.starBtn.setTitle(self.viewModel.model.likes_count, for: .normal)
                WTKTools.changeImageWithImgView(imgView: self.starImg, name: "w_star1N")
            }
            self.viewModel.starCommand.onNext(self.starBtn)
        }).addDisposableTo(myDisposeBag)
        
        shareBtn.rx.tap.subscribe({(event) in
            
        }).addDisposableTo(myDisposeBag)
    }
    
    func configView() {
        wPrint(message: self.viewModel.model.content_url)
        webView.frame = self.view.frame
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.delegate = self
        webView.scrollView.contentInset = UIEdgeInsets.init(top: kWidth / 2.18 , left: 0, bottom: 0, right: 0)
        self.view.addSubview(webView)
        
        progressView.frame = CGRect.init(x: 0, y: 64, width: kWidth, height: 1.5)
        progressView.progressTintColor = UIColor.green
        progressView.progress = 0
        self.view.addSubview(progressView)
        
        bgView.frame = CGRect.init(x: 0, y: -kWidth / 2.18, width: kWidth, height: kWidth / 2.18)
        webView.scrollView.addSubview(bgView)
        
        headView.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: kWidth / 2.18)
        headView.contentMode = .scaleAspectFill
        bgView.addSubview(headView)
        
        titleLabel.frame = CGRect.init(x: 20, y: kWidth / 2.18 - kWidth / 2.18 / 3 , width: kWidth - 40, height: kWidth / 2.18 / 3)
        titleLabel.textColor = UIColor.white
        titleLabel.font = wSystemFont(size: 18)
        bgView.addSubview(titleLabel)
        
        bottomView.frame = CGRect.init(x: 0, y: kHeight - 45, width: kWidth, height: 45)
        bottomView.backgroundColor = WTKColor(r: 254, g: 255, b: 253, a: 1)
        self.view.addSubview(bottomView)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 0.3))
        line.backgroundColor = LINE_COLOR
        bottomView.addSubview(line)
        
        let width = kWidth / 3.0
        starBtn.frame = CGRect.init(x: 0, y: 0, width: width, height: 45)
//        starBtn.titleLabel?.textAlignment = .left
        starBtn.contentHorizontalAlignment = .left
        starBtn.setTitleColor(WTKColor(r: 120, g: 120, b: 120, a: 1), for: .normal)
        starBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: width / 2.0 , bottom: 0, right: 0)
        bottomView.addSubview(starBtn)
        
        starImg.frame = CGRect.init(x: width / 2.0 - 30, y: 45 / 2 - 10, width: 20, height: 20)
        starImg.image = UIImage.init(named: "w_star1N")
        starBtn.addSubview(starImg)
        

        
        shareBtn.frame = CGRect.init(x: width, y: 0, width: width, height: 45)
        shareBtn.contentHorizontalAlignment = .left
        shareBtn.setTitleColor(WTKColor(r: 120, g: 120, b: 120, a: 1), for: .normal)
        shareBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: width / 2.0 , bottom: 0, right: 0)
        bottomView.addSubview(shareBtn)
        
        let shareImg = UIImageView.init(frame: CGRect.init(x: width / 2.0 - 30, y: 45 / 2 - 10, width: 20, height: 20))
        shareImg.image = UIImage.init(named: "w_share1")
        shareBtn.addSubview(shareImg)
        
        commentBtn.frame = CGRect.init(x: width * 2, y: 0, width: width, height: 45)
        commentBtn.contentHorizontalAlignment = .left
        commentBtn.setTitleColor(WTKColor(r: 120, g: 120, b: 120, a: 1), for: .normal)
        commentBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: width / 2.0 , bottom: 0, right: 0)
        bottomView.addSubview(commentBtn)
        
        let commentImg = UIImageView.init(frame: CGRect.init(x: width / 2.0 - 30, y: 45 / 2 - 10, width: 20, height: 20))
        commentImg.image = UIImage.init(named: "w_comment1")
        commentBtn.addSubview(commentImg)
        
        let leftLine = UIView.init(frame: CGRect.init(x: width, y: 8, width: 0.4, height: 29))
        leftLine.backgroundColor = LINE_COLOR
        bottomView.addSubview(leftLine)
        
        let rightLine = UIView.init(frame: CGRect.init(x: width * 2, y: 8, width: 0.4, height: 29))
        rightLine.backgroundColor = LINE_COLOR
        bottomView.addSubview(rightLine)
//        webView.scrollView.contentInset = UIEdgeInsets.init(top: kWidth / 2.18 + 64, left: 0, bottom: 0, right: 0)
        
    }
    
//    MARK: scrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
//        初始 -236   隐藏 -64 
        if scrollView.contentOffset.y < -64.0 {
            let origin = -(kWidth / 2.18 + 64.0)
            let y = scrollView.contentOffset.y
            let distance = y - origin
            
            var center = CGPoint.init(x: bgView.frame.width / 2.0, y: bgView.frame.height / 2.0)
            let scall = y / origin
            var size = headView.frame.size
            if scrollView.contentOffset.y < origin {
//                顶部下拉
                bgView.layer.masksToBounds = false
                center.y = center.y + distance / 2.0
                size.height = bgView.frame.height + max(-distance, distance)
                size.width = max(kWidth, kWidth * scall)
                
            } else {
//                上滑
                bgView.layer.masksToBounds = true
                center.y = center.y + distance / 1.6
            }
            headView.center = center
            headView.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        }
     
    }
    
//    MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == progressPath {
            self.progressView.alpha = 1.0
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            if self.webView.estimatedProgress >= 1.0 {
                self.progressView.alpha = 0
                
//                webView.removeObserver(self, forKeyPath: progressPath)
//                webView.removeObserver(self, forKeyPath: titlePath)
            }
        } else if keyPath == titlePath {
            
        }
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
