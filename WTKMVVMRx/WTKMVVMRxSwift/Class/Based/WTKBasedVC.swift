//
//  WTKBasedVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/11.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional
import RxDataSources
class WTKBasedVC: UIViewController {

//   var vm : WTKBasedVM{
//        get{
//            return self.vm
//        }
//    }
    private(set) var vm : WTKBasedVM! = nil
    
    var myDisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindToViewModel()
//        self.vm.services.vc = self.navigationController
    }
    
    required init(viewModel vm : WTKBasedVM){
        super.init(nibName: nil, bundle: nil)
        self.vm = vm
        
    }
    
//    MARK: BIND
    func bindToViewModel(){

        self.rx.observe(String.self, "vm.title").subscribe { [unowned self] (event) in
            let x = event.element
            self.navigationItem.title = x!
        }.addDisposableTo(DisposeBag())
    }
    
//    MARK: initView
    func initView(){
        self.view.backgroundColor = BACK_COLOR
        if self.navigationController != nil && self != self.navigationController?.viewControllers.first {
//            resetNavi()
            
        }
    }
    
    func resetNavi(){
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.setBackgroundImage(UIImage.init(named: "backbutton_icon3"), for: .normal)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        leftBtn.addTarget(self, action: #selector(WTKBasedVC.backBtnClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        
    }
    
    func backBtnClick(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        wPrint(message: "\(NSStringFromClass(self.classForCoder))释放")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    deinit {
//        print(NSStringFromClass(self.classForCoder))
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
