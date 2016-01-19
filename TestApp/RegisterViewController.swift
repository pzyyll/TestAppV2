//
//  RegisterViewController.swift
//  LoginUI
//
//  Created by pzyyll on 15/11/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    var btn_BackLogin: UIButton!
    
    var labEmail: UILabel!
    var labPwd: UILabel!
    var labCheck: UILabel!

    var textEmail: UITextField!
    var textPwd: UITextField!
    var textCheck: UITextField!
    
    var btnReg: UIButton!
    
    override func loadView() {
        super.loadView()
        
        var rect = CGRectMake(12, 12, 80, 80)
        btn_BackLogin = UIButton(frame: rect)
        
        self.view.addSubview(btn_BackLogin)
        
        rect.origin.x = self.view.frame.width / 5
        rect.origin.y = self.view.frame.height / 8
        rect.size = CGSizeMake(200, 30)
        textEmail = UITextField(frame: rect)
        self.view.addSubview(textEmail)
        
        rect = textEmail.frame
        rect.origin.y += textEmail.frame.height + 10;
        textPwd = UITextField(frame: rect)
        self.view.addSubview(textPwd)
        
        rect = textPwd.frame
        rect.origin.y += rect.height + 10;
        rect.size.width /= 4;
        textCheck = UITextField(frame: rect)
        self.view.addSubview(textCheck)
        
        rect = textCheck.frame
        rect.origin.y += rect.height + 10;
        rect.size = textPwd.frame.size
        btnReg = UIButton(frame: rect)
        self.view.addSubview(btnReg)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        btn_BackLogin.setTitle("Back", forState: .Normal)
        btn_BackLogin.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn_BackLogin.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn_BackLogin.addTarget(self, action: Selector("backLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
        
        textEmail.borderStyle = .RoundedRect
        textEmail.clearButtonMode = .WhileEditing
        textEmail.textAlignment = .Left
        textEmail.returnKeyType = .Next
        textEmail.delegate = self
        
        textPwd.borderStyle = .RoundedRect
        textPwd.clearButtonMode = .WhileEditing
        textPwd.textAlignment = .Left
        textPwd.returnKeyType = .Next
        textPwd.delegate = self
        
        textCheck.borderStyle = .RoundedRect
        textCheck.clearButtonMode = .WhileEditing
        textCheck.textAlignment = .Left
        textCheck.returnKeyType = .Done
        textCheck.delegate = self
        
        btnReg.setTitle("Sign Up", forState: .Normal)
        btnReg.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btnReg.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        btnReg.backgroundColor = UIColor(red: 156 / 255, green: 205 / 255, blue: 207 / 255, alpha: 1)
        btnReg.addTarget(self, action: Selector("regHandler"), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backLogin() {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textEmail.resignFirstResponder()
        
        return true
    }
    
    func regHandler() {
        let alterView = UIAlertController(title: "Warn", message: "暂时不能注册！", preferredStyle: .Alert)
        alterView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alterView, animated: true, completion: nil)
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
