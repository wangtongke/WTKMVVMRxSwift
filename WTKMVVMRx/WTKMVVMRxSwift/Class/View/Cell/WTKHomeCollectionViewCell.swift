//
//  WTKHomeCollectionViewCell.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/20.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKHomeCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {

// TODO: property
    @IBOutlet weak var tableView: UITableView!
    var viewModel : WTKHomeVM!
    
    var dataArray = NSArray()
    
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
    }
    
    func updateWithData(data : NSArray) {
        self.dataArray = data
        reloadData()
    }
    
    func reloadData(){
        self.tableView.reloadData()
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

    
}
