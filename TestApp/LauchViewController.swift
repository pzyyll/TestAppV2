//
//  LauchViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/20.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class LauchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        let factory = AbsViewFactory(FactoryType: FactoryForAnimaOfCycle())
        let layer = factory.createAnima()
        layer.position = self.view.center
        layer.position.y -= 100
        self.view.layer.addSublayer(layer)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
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
