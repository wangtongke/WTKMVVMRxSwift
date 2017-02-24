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
    var choiceView : WTKHomeChoiceView!
    var collectionView : UICollectionView!
    var refreshControl : CBStoreHouseRefreshControl!
    
//    TODO: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        let param : NSDictionary = ["gender" : WTKUser.shareInstance.sex == true ? "1" : "2","generation" : WTKUser.shareInstance.generation]
        
        print("2")
    }
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
//        viewModel.basedCommand.onNext(1 as AnyObject)
        
        viewModel.basedData.subscribe { [unowned self](event) in
            let x = event.element!
            self.choiceView.data = x as! [WTKChannel]
        }.addDisposableTo(myDisposeBag)
    
        
    }
    
    

    
    override func initView() {
        super.initView()
        self.automaticallyAdjustsScrollViewInsets = false
        
//        choiceView
        choiceView = WTKHomeChoiceView.init(title: [], frame: CGRect.init(x: 0, y: 64, width: kWidth, height: 40))
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
        collectionView.register(UINib.init(nibName: "WTKHomeCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.collectionView)

    }
    

    func configCellWithIndexPath(cell : WTKHomeCollectionViewCell, indexPath : IndexPath) {
        
    }
    
//    FIXME: collectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WTKHomeCollectionViewCell
        cell.viewModel = self.viewModel
        self.configCellWithIndexPath(cell: cell, indexPath: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
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
