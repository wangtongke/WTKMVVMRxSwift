//
//  WTKMeVC.swift
//  WTKMVVMRxSwift
//
//  Created by 王同科 on 2017/1/12.
//  Copyright © 2017年 王同科. All rights reserved.
//

import UIKit

class WTKMeVC: WTKBasedVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let start = CFAbsoluteTimeGetCurrent()
        var sum=0
        for i in 0...10000000{
            sum+=i
        }
        print(sum)
        print(String(CFAbsoluteTimeGetCurrent()-start)+" seconds")
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
