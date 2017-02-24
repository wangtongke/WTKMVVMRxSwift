//
//  WTKProductVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/12.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKProductVC: WTKBasedVC,UITableViewDelegate,UITableViewDataSource {

    var refreshControl : CBStoreHouseRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = THEME_COLOR
        let tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.refreshControl = CBStoreHouseRefreshControl.attach(to: tableView, target: self, refreshAction: #selector(WTKProductVC.refreshMethod), plist: "WANGTONGKE", color: UIColor.black, lineWidth: 1.5, dropHeight: 90, scale: 1, horizontalRandomness: 150, reverseLoadingAnimation: true, internalAnimationFactor: 0.5)
        self.view.addSubview(tableView)
        
    }
    
    func refreshMethod() {
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(3)
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.refreshControl.finishingLoading()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentInset.top)
        self.refreshControl.scrollViewDidScroll()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.refreshControl.scrollViewDidEndDragging()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.purple
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
