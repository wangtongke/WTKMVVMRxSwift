//
//  WTKTableViewController.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/19.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKTableViewController: WTKBasedVC,UIScrollViewDelegate,UITableViewDelegate {

    var tvm : WTKTableVM{
        return self.vm as! WTKTableVM
    }
    private(set) var tableView : UITableView! = nil
    
    var refreshControl : CBStoreHouseRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func bindToViewModel() {
        super.bindToViewModel()
    }
    
    override func initView() {
        super.initView()
        self.tableView = UITableView.init(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        if self.tvm.shouldReresh {
            refreshControl = CBStoreHouseRefreshControl.attach(to: self.tableView,
                                                               target: self,
                                                               refreshAction: #selector(WTKTableViewController.basedRefresh),
                                                               plist: "WANGTONGKE",
                                                               color: UIColor.green,
                                                               lineWidth: 1.5,
                                                               dropHeight: 70,
                                                               scale: 1.0,
                                                               horizontalRandomness: 150,
                                                               reverseLoadingAnimation: true,
                                                               internalAnimationFactor: 0.7)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.refreshControl != nil {
            self.refreshControl.scrollViewDidScroll()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.refreshControl != nil {
            self.refreshControl.scrollViewDidEndDragging()
        }
    }
    
    func basedRefresh() {
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(3)
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.refreshControl.finishingLoading()
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
