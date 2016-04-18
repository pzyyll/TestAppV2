//
//  TSUINavigationController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/17.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class TSUINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var cnt = 0;
    override func pushViewController(viewController: UIViewController, animated: Bool) {

        
        if (!self.viewControllers.isEmpty) {
            
            let backBtnItem = UIBarButtonItem(image: UIImage(named: "Icon_back_alpha"), style: .Plain, target: self, action: #selector(self.backAction))
            
            viewController.navigationItem.setLeftBarButtonItems([backBtnItem], animated: true)
        }
        super.pushViewController(viewController, animated: animated)
    
    }
    
    func backAction() {
        self.visibleViewController?.navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
