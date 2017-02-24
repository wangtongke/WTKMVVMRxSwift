//
//  WTKHomeVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/12.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKHomeVC: WTKBasedVC,UICollectionViewDelegate,UICollectionViewDataSource {

    var viewModel : WTKHomeVM{
        return self.vm as! WTKHomeVM
    }
//   override var vm: WTKHomeVM{
//        get {
//            return self.vm
//        }
//        set {
//            self.vm = newValue
//        }
//    }
    //choiceView
    var choiceView = WTKHomeChoiceView.init(title: [], frame: CGRect.init(x: 0, y: 64, width: kWidth, height: 40))
    var collectionView : UICollectionView!
    var refreshControl : CBStoreHouseRefreshControl!
    var channelData = NSMutableArray()
    var currentChannel : WTKChannel!
    var currentIndex : Int = 0
    var dataArray = NSMutableDictionary()
    
//    TODO: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("111111")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        print("1")
        let param : NSDictionary = ["gender" : WTKUser.shareInstance.sex == true ? "1" : "2","generation" : WTKUser.shareInstance.generation]
        
        print("2")

        configView()


    }
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
//        viewModel.basedCommand.onNext(1 as AnyObject)
        
        viewModel.basedData.subscribe { [unowned self](event) in
            let x = event.element!
            self.choiceView.data = x as! [WTKChannel]
            for obj in x {
                self.channelData.add(obj)
            }
            guard let obj = x.firstObject as! WTKChannel! else{
                return
            }
            self.currentChannel = obj
            self.viewModel.selectedChannelCommand.onNext([0 : obj])
            self.collectionView.reloadData()
        }.addDisposableTo(myDisposeBag)
        
        choiceView.selectedBlock = {
           [unowned self] (tag,channel) in
            self.collectionView.scrollToItem(at: IndexPath.init(row: tag, section: 0), at: .left, animated: true)
            self.currentChannel = channel
            self.currentIndex = tag
            self.viewModel.selectedChannelCommand.onNext([tag : channel])
        }
        
        viewModel.putDetaileData
            .asObservable()
            .subscribe { [unowned self] (event) in
                let x = event.element!
                print(x)
                guard let array = x["data"] else {
                    return
                }
                self.dataArray[self.currentIndex] = array
                if self.collectionView != nil {
                    self.collectionView.reloadData()
                }
                guard let refreshControl = x["table"] else {
                    return
                }
                (refreshControl as! CBStoreHouseRefreshControl).finishingLoading()
                
        }.addDisposableTo(myDisposeBag)
        
    }
    
    

    
    func configView() {
        
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
//        choiceView
        self.view.addSubview(choiceView)
        
        
        let layout = UICollectionViewFlowLayout.init()
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 40 + 64, width: kWidth, height: kHeight - 64 - 49 - 30), collectionViewLayout: layout)
        layout.itemSize = CGSize.init(width: kWidth, height: collectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "WTKHomeCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collectionView)

    }
    

    func configCellWithIndexPath(cell : WTKHomeCollectionViewCell, indexPath : IndexPath) {
        guard let array = self.dataArray[indexPath.row] else {
            return
        }
        cell.updateWithData(data: array as! NSArray)
        if cell.isInit {
            cell.refreshComman.subscribe { [unowned self] (event) in
                //            refresh
                let x = event.element!
                self.viewModel.refreshCommand.onNext(["channel" : [self.currentIndex : self.currentChannel], "table" : x])
                }.addDisposableTo(myDisposeBag)
            cell.selectedCommand.subscribe({ [unowned self] (event) in
                let x = event.element!
                self.viewModel.cellClickCommand.onNext(x)
//                let viewModel = WTKStrategyDetaileVM.init(services: WTKViewModelNvigationImpl(), params: ["title": "攻略详情" as AnyObject])
                //            viewModel.model = x
                //            self.services.pushViewModel(viewModel: viewModel, animated: true)
//                let vcClass = NSClassFromString("WTKMVVMRxSwift.WTKStrategyDetaileVC") as! WTKBasedVC.Type
//                let vc = vcClass.init(viewModel: viewModel)
//                self.navigationController?.pushViewController(vc, animated: true)
            }).addDisposableTo(myDisposeBag)
            cell.isInit = false
        }
    }
    
//    FIXME: collectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WTKHomeCollectionViewCell
        cell.viewModel = self.viewModel
        self.configCellWithIndexPath(cell: cell, indexPath: indexPath)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channelData.count;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.choiceView.updateWithIndex(tag: index)
    }
    

    
    


    
    
    
    required init(viewModel vm: WTKBasedVM) {
        super.init(viewModel: vm)
//        self.vm = vm as! WTKHomeVM
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
