//
//  WTKTabbarController.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/11.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class WTKTabbarController: UITabBarController {
    var naviArray : NSMutableArray!
    var services : WTKViewModelServicesType! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initObj()
        initChildVC()
        
    }
    
    func registNavigationHooks() {
        
    }
    
    func initObj(){
        services = WTKViewModelNvigationImpl()
        naviArray = NSMutableArray.init()
    }
    
//    MARK: - 动画
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.beginAnimation()
    }
    override var selectedIndex: Int{
        didSet{
            super.selectedIndex = selectedIndex
            self.beginAnimation()
        }
    }
    
    func beginAnimation(){
        let animation = CATransition.init()
        animation.duration = 0.5
        animation.type = kCATransitionFade
        animation.subtype = kCATransitionFromBottom
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        self.view.layer.add(animation, forKey: "switchView")
    }
    
//    MARK: - 初始化子VC
    func initChildVC(){
        let array : NSArray = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "Tabbar", ofType: "plist")!)!
        
        for data in array {
            let dic = data as! [String : String]
            let nav = setChildVC(vm: dic["vm"]!, vc: dic["vc"]!, title: dic["title"]!, imageName: dic["normalName"]!, selectedName: dic["selectedName"]!)
            addChildViewController(nav)
            naviArray.add(nav)
        }
    }
    
    func setChildVC(vm : String, vc : String, title : String, imageName : String, selectedName : String) -> WTKNavigationController {
        let vcClass = NSClassFromString("WTKMVVMRxSwift.\(vc)") as! WTKBasedVC.Type
        let vmClass = NSClassFromString("WTKMVVMRxSwift.\(vm)")  as! WTKBasedVM.Type
        let vm = vmClass.init(services: self.services, params: ["title" : title as AnyObject])
        let vc = vcClass.init(viewModel: vm)
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: selectedName)
        vc.title = title
        
        let dic = [NSForegroundColorAttributeName: BLACK_COLOR, NSFontAttributeName: wSystemFont(size: 12)]
        vc.tabBarItem.setTitleTextAttributes(dic, for: UIControlState.normal)
        
        let selectedDic = [NSForegroundColorAttributeName: THEME_COLOR, NSFontAttributeName: wSystemFont(size: 12)]
        vc.tabBarItem.setTitleTextAttributes(selectedDic, for: UIControlState.selected)
        
        let nav = WTKNavigationController.init(rootViewController: vc)
        
        return nav
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
