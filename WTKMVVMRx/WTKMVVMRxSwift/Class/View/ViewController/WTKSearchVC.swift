//
//  WTKSearchVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/28.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKSearchVC: WTKBasedVC,UISearchBarDelegate {

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        
    }
    
    override func bindToViewModel() {
        
    }
    
    func configView(){
        self.searchBar.barStyle = .default
        self.searchBar.delegate = self
        self.searchBar.placeholder = "搜索"
        self.searchBar.layer.cornerRadius = 5
        self.searchBar.layer.masksToBounds = true
        self.searchBar.layer.borderColor = WTKColor(r: 210, g: 210, b: 210, a: 1).cgColor
        self.searchBar.layer.borderWidth = 0.4
        self.searchBar.frame = CGRect.init(x: 1, y: 8, width: kWidth - 80, height: 28)
        
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth - 60, height: 44 * kScaleWidth))
        self.navigationItem.titleView = bgView
        bgView.addSubview(self.searchBar)
        print(123)
        print("wwww")
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
