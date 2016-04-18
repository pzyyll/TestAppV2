//
//  RegisterViewController.swift
//  LoginUI
//
//  Created by pzyyll on 15/11/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var regUser: TSUITextField!
    var pwd: TSUITextField!
    var verify: TSUITextField!
    
    var btnGetVerify: UIButton!
    var btnReg: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.btnStatus(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
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
        //
    }
    
    func register() {
        
    }
    
    func btnStatus(sender: NSNotification) {
        if (!self.regUser.text!.isEmpty && !self.pwd.text!.isEmpty) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
