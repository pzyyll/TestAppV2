//
//  RegisterViewController.swift
//  LoginUI
//
//  Created by pzyyll on 15/11/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit
import KeychainAccess

class RegisterViewController: UIViewController, UITextFieldDelegate, RegBLDelegate {
    
    var regUser: TSUITextField!
    var pwd: TSUITextField!
    var verify: TSUITextField!
    
    var btnGetVerify: UIButton!
    var btnReg: UIButton!
    
    var regBL: RegBL!
    var regUserInfo: UserInfo!
    var code: String!
    var timer: Timer!
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.btnStatus(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        self.timer = Timer()
        
        self.regBL = RegBL()
        self.regBL.delegate = self
        
        self.configView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func configView() {
        let viewFactory = AbsViewFactory(FactoryType: FactoryForTextFiledOfLogin())
        var conns = Array<[NSLayoutConstraint]>()
        
        let configColor = [TSUITextField.BottomLineColorOfNormal: UIColor.lightGrayColor(),
                           TSUITextField.BottomLineColorOfSelected: UIColor.orangeColorV1()];
        self.regUser = viewFactory.createControl(
            ["手机"],
            action: nil,
            sender: nil,
            otherConfig: configColor) as! TSUITextField
        self.view.addSubview(self.regUser)
        
        self.pwd = viewFactory.createControl(["密码"], action: nil, sender: nil, otherConfig: configColor) as! TSUITextField
        self.pwd.secureTextEntry = true
        self.view.addSubview(self.pwd)
        
        self.verify = viewFactory.createControl(["验证码"], action: nil, sender: nil, otherConfig: configColor) as! TSUITextField
        self.view.addSubview(self.verify)
        
        self.regUser.returnKeyType = .Next
        self.pwd.returnKeyType = .Next
        self.verify.returnKeyType = .Done
        self.regUser.delegate = self
        self.pwd.delegate = self
        self.verify.delegate = self
        
        viewFactory.viewFactory = FactoryForBtnOfNormal();
        self.btnGetVerify = viewFactory.createControl(
            ["获取验证码"],
            action: #selector(self.getVerify),
            sender: self,
            otherConfig: ["bgImg_Normal": "verify_btn_normal",
            "bgImg_Clicked": "verify_btn_clicked",
            "bgImg_Disabled": "verify_btn_disabled",
            "font": UIFont.systemFontOfSize(10)]) as! UIButton
        self.btnGetVerify.enabled = false
        self.view.addSubview(self.btnGetVerify)
        
        viewFactory.viewFactory = FactoryForBtnOfNormal();
        self.btnReg = viewFactory.createControl(
            ["注册"],
            action: #selector(self.register),
            sender: self,
            otherConfig: ["bgImg_Normal": "login_btn_normal",
                "bgImg_Clicked": "login_btn_clicked",
                "bgImg_Disabled": "login_btn_disabled"]) as! UIButton
        self.btnReg.enabled = false
        self.view.addSubview(self.btnReg)

        
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("H:|-80-[regUser]-80-|", options: .AlignAllTop, metrics: nil, views: ["regUser": self.regUser]))
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[regUser(==heigh)]", options: .AlignAllLeft, metrics: ["heigh": self.regUser.frame.height], views: ["regUser": self.regUser]))
    
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("H:[pwd(==regUser)]", options: .AlignAllLeft, metrics: nil, views: ["pwd": self.pwd, "regUser": self.regUser]))
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[regUser]-[pwd(==regUser)]", options: .AlignAllLeft, metrics: nil, views: ["pwd": self.pwd, "regUser": self.regUser]))
        
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[pwd]-[verify(==pwd)]", options: .AlignAllLeft, metrics: nil, views: ["pwd": self.pwd, "verify": self.verify]))
        NSLayoutConstraint(item: self.verify, attribute: .Width, relatedBy: .Equal, toItem: self.pwd, attribute: .Width, multiplier: 1/2, constant: -5).active = true
        
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[pwd]-[btnGetVerify(==pwd)]", options: .AlignAllRight, metrics: nil, views: ["pwd": self.pwd, "btnGetVerify": self.btnGetVerify]))
        NSLayoutConstraint(item: self.btnGetVerify, attribute: .Width, relatedBy: .Equal, toItem: self.pwd, attribute: .Width, multiplier: 1/2, constant: -5).active = true
        
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnReg(==pwd)]", options: .AlignAllLeft, metrics: nil, views: ["btnReg": self.btnReg, "pwd": self.pwd]))
        conns.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[verify]-[btnReg(==verify)]", options: .AlignAllLeft, metrics: nil, views: ["btnReg": self.btnReg, "verify": self.verify]))
        
        for item in conns {
            NSLayoutConstraint.activateConstraints(item)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backLogin() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getVerify() {
        //note: check phone number
        
        self.regUserInfo = UserInfo()
        self.regUserInfo.userName = self.regUser.text!
        self.regUserInfo.pwd = self.pwd.text!
        self.regBL.queryUser(regUserInfo)
        //NSTimer.scheduledTimerWithTimeInterval(1, target: <#T##AnyObject#>, selector: <#T##Selector#>, userInfo: <#T##AnyObject?#>, repeats: <#T##Bool#>)
    }
    
    func register() {
        if self.verify.text == self.code {
            MBProgressHUD.showToView(self.view, mess: "请稍后...", icon: nil)
            self.regBL.regUser(self.regUserInfo)
        } else {
            MBProgressHUD.showDelayHUDToView(self.view, mess: "验证码错误！", icon: nil)
            self.verify.becomeFirstResponder()
        }
    }
    
    func btnStatus(sender: NSNotification) {
        if (!self.regUser.text!.isEmpty && !self.pwd.text!.isEmpty && self.timer.sec <= 0) {
            self.btnGetVerify.enabled = true
        } else {
            self.btnGetVerify.enabled = false
        }
        
        if (!self.regUser.text!.isEmpty && !self.pwd.text!.isEmpty && !self.verify.text!.isEmpty) {
            self.btnReg.enabled = true
        } else {
            self.btnReg.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(self.regUser) {
            textField.resignFirstResponder()
            self.pwd.becomeFirstResponder()
        } else if textField.isEqual(self.pwd) {
            textField.resignFirstResponder()
            self.verify.becomeFirstResponder()
        } else {
            self.verify.resignFirstResponder()
            self.register()
        }
        
        return true
    }
    
    //RegBLDelegate
    func regUserIsExists(exists: Bool) {
        if exists {
            MBProgressHUD.showDelayHUDToView(self.view, mess: "user had reged!", icon: "Icon_err1")
            self.regUser.becomeFirstResponder()
            self.regUser.bottomLine.backgroundColor = UIColor.redColor()
        } else {
            self.btnGetVerify.titleLabel?.text = "30s"
            self.timer.sec = 30
            self.timer.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.timerhandle), userInfo: nil, repeats: true)
            self.btnGetVerify.enabled = false
            self.code = self.regBL.getCode(self.regUserInfo)
            self.code = "123456"
        }
    }
    func regUserIsFinished(ok: Bool) {
        MBProgressHUD.hideFromView(self.view)
        if ok {
            let keychain = Keychain(service: identifier_Keychain, accessGroup: "ik1")
            keychain["user"] = self.regUserInfo.userName
            keychain["pwd"] = self.regUserInfo.pwd
            
            MBProgressHUD.showDelayHUDToView(self.view, mess: "加载页面中...", icon: nil)
            UIApplication.sharedApplication().keyWindow?.rootViewController = MainTabViewController()
        }
    }
    func queryFail(fail: Bool) {
        MBProgressHUD.hideFromView(self.view)
        if fail {
            MBProgressHUD.showDelayHUDToView(self.view, mess: "network err", icon: "Icon_err2")
        }
    }
    
    func timerhandle() {
        print(self.timer.sec)
        if self.timer.sec < 0 {
            self.btnGetVerify.titleLabel?.text = "获取验证码"
            self.btnGetVerify.enabled = true
            self.timer.stop()
            return
        }
        self.btnGetVerify.titleLabel?.text = "\(self.timer.sec)s"
        self.timer.update_d()
        
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
