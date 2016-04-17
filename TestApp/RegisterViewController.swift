//
//  RegisterViewController.swift
//  LoginUI
//
//  Created by pzyyll on 15/11/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let backBtnItem = UIBarButtonItem(image: UIImage(named: "Icon_back_alpha"), style: .Plain, target: self, action: #selector(self.backLogin))
        let backTitie = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        backTitie.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Highlighted)

        self.navigationItem.setLeftBarButtonItems([backBtnItem, backTitie], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backLogin() {
        self.navigationController?.popViewControllerAnimated(true)
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
