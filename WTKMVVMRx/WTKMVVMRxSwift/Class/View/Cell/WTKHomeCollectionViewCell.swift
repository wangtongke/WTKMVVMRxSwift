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
    
    var dataArray : NSMutableArray {
        return NSMutableArray.init()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
//    MARK: tableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    
}
