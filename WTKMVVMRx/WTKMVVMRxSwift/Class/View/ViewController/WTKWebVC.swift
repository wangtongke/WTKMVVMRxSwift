//
//  WTKWebVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/2/10.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKWebVC: WTKBasedVC {

    var viewModel : WTKWebVM {
        return self.vm as! WTKWebVM
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(222)
        // Do any additional setup after loading the view.
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
