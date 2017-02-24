//
//  WTKHomeCollectionViewCell.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/20.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class WTKHomeCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

// TODO: property
    @IBOutlet weak var tableView: UITableView!
    var viewModel : WTKHomeVM!
    
    var dataArray = NSArray()
    
    var isInit = true
    
    private var isRefresh = false
    
    private var refreshControl : CBStoreHouseRefreshControl!
    
    private(set) var refreshComman : PublishSubject<CBStoreHouseRefreshControl>!
    
    private(set) var selectedCommand : PublishSubject<WTKHomeModel>!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(WTKHomeTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = WTKColor(r: 239, g: 239, b: 243, a: 1)
        tableView.separatorStyle = .none
        tableView.rowHeight = kWidth / 2.18
        
        refreshControl = CBStoreHouseRefreshControl.attach(to: self.tableView,
                                                           target: self,
                                                           refreshAction: #selector(WTKHomeCollectionViewCell.refreshHeader),
                                                           plist: "WANGTONGKE",
                                                           color: UIColor.black,
                                                           lineWidth: 1.5,
                                                           dropHeight: 90,
                                                           scale: 1,
                                                           horizontalRandomness: 150,
                                                           reverseLoadingAnimation: true,
                                                           internalAnimationFactor: 0.5)
        
        refreshComman = PublishSubject<CBStoreHouseRefreshControl>()
        selectedCommand = PublishSubject<WTKHomeModel>()
        
    }
    
    func refreshHeader() {
        self.isRefresh = true
        refreshComman.onNext(refreshControl)
        
    }
    
    func refreshFoot() {
        
    }
    
    func updateWithData(data : NSArray) {
        self.dataArray = data
        reloadData()
    }
    
    func reloadData(){
        self.tableView.reloadData()
        if self.isRefresh {
//            self.refreshControl.finishingLoading()
        }
        self.isRefresh = false
        
    }
    
//    MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCommand.onNext(dataArray[indexPath.row] as! WTKHomeModel)
    }
    
//    MARK: tableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WTKHomeTableViewCell
        let model = self.dataArray[indexPath.row] as! WTKHomeModel
        cell.updateWithModel(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
//    MARK: scrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.refreshControl.scrollViewDidScroll()
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.refreshControl.scrollViewDidEndDragging()
    }

    
}
