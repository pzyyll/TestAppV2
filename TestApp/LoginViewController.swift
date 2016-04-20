//
//  LoginViewController.swift
//  LoginUI
//
//  Created by pzyyll on 15/11/20.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, LoginBLDelegate {
    
    var userText: TSUITextField!
    var pwdText: TSUITextField!
    var btn_Login: UIButton!
    var btn_Reg: UIButton!
    
    override func loadView() {
        super.loadView()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //self.view.backgroundColor = UIColor.grayLightColor236()
        self.title = "登录"
        

        self.viewConfig()


        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.loginStatus(_:)), name: UITextFieldTextDidChangeNotification, object: nil)
    }
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    func viewConfig() {
        let viewFactory = AbsViewFactory(FactoryType: FactoryForTextFiledOfLogin());
        
        userText = viewFactory.createControl(
            ["邮箱/用户名"],
            action: nil,
            sender: nil,
            otherConfig: [
                "leftView":"Icon_login_user",
                TSUITextField.BottomLineColorOfNormal: UIColor.lightGrayColor(),
                TSUITextField.BottomLineColorOfSelected: UIColor.orangeColorV1()
            ]
        ) as! TSUITextField;
        userText.translatesAutoresizingMaskIntoConstraints = false
        userText.frame.size.width = 350;
        userText.frame.size.height = 30;
        userText.returnKeyType = .Next
        userText.delegate = self
        userText.becomeFirstResponder()
        self.view.addSubview(userText)
        
        var conss: Array<[NSLayoutConstraint]> = Array<[NSLayoutConstraint]>()
        
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("[tView(==\(userText.frame.width))]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["tView": userText]))
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[tView(==\(userText.frame.height))]", options: .AlignAllTop, metrics: nil, views: ["tView": userText]))
        
        NSLayoutConstraint(item: userText, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0).active = true
        
        pwdText = viewFactory.createControl(
            ["密码"],
            action: nil,
            sender: nil,
            otherConfig: [
                "leftView":"Icon_login_pwd",
                TSUITextField.BottomLineColorOfNormal: UIColor.lightGrayColor(),
                TSUITextField.BottomLineColorOfSelected: UIColor.orangeColorV1()
                ]
            ) as! TSUITextField;
        pwdText.translatesAutoresizingMaskIntoConstraints = false
        pwdText.frame.size.width = userText.frame.width
        pwdText.frame.size.height = userText.frame.height
        pwdText.returnKeyType = .Done
        pwdText.secureTextEntry = true
        pwdText.delegate = self
        self.view.addSubview(pwdText)
        
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[userText]-4-[pwdText(==\(pwdText.frame.height))]", options: .AlignAllLeft, metrics: nil, views: ["userText": userText, "pwdText": pwdText]))
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("H:[pwdText(==\(pwdText.frame.width))]", options: .AlignAllTop, metrics: nil, views: ["pwdText": pwdText]))
        
        viewFactory.viewFactory = FactoryForBtnOfNormal()
        btn_Login = viewFactory.createControl(
            ["登录"],
            action: #selector(LoginViewController.login),
            sender: self,
            otherConfig: ["bgImg_Normal": "login_btn_normal",
                "bgImg_Clicked": "login_btn_clicked",
                "bgImg_Disabled": "login_btn_disabled"
            ]) as! UIButton;
        btn_Login.enabled = false
    
        btn_Login.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btn_Login)
        
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[topView]-[btnLogin(==34)]", options: .AlignAllLeft, metrics: nil, views: ["topView": pwdText, "btnLogin": btn_Login]))
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnLogin(==topView)]", options: .AlignAllLeft, metrics: nil, views: ["btnLogin": btn_Login, "topView": pwdText]))
        
        viewFactory.viewFactory = FactoryForBtnOfBorder();
        btn_Reg = viewFactory.createControl(
            ["注册"],
            action: #selector(self.register(_:)),
            sender: self,
            otherConfig: ["bgImg_Clicked": "reg_btn_cliced"]) as! UIButton
        btn_Reg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btn_Reg)
        
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnLogin]-[btnReg(==btnLogin)]", options: .AlignAllLeft, metrics: nil, views: ["btnLogin": btn_Login, "btnReg": btn_Reg]))
        conss.append(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnReg(==topView)]", options: .AlignAllLeft, metrics: nil, views: ["topView": btn_Login, "btnReg": btn_Reg]))
        
        
        for item in conss {
            NSLayoutConstraint.activateConstraints(item)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(self.userText) {
            self.pwdText.becomeFirstResponder()
        }
        if textField.isEqual(self.pwdText) {
            textField.resignFirstResponder()
            self.login()
        }
        return true;
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //print(textField.text)
        //change the login button states
        
        return true
    }
    
    

    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    
    func login() {

        let user = UserInfo()
        user.userName = self.userText.text!
        user.pwd = self.pwdText.text!
        
        let log = LoginBL()
        MBProgressHUD.showLoadingHUDToView(self.view, icon: nil)
        log.login(user)
        log.delegate = self
    }
    
    func register(sender: UIButton) {
        //var reg = RegisterViewController()
          MBProgressHUD.showDelayHUDToView(self.view, mess: "loading", icon: nil)
//        let sb = UIStoryboard(name: "LoginMainStoryboard", bundle: nil)
//        let reg = sb.instantiateViewControllerWithIdentifier("123")
//        self.navigationController?.pushViewController(reg, animated: true)
    }
    
    func loginStatus(sender: NSNotification) {
//        sender.object!.isEqual(userText)
//        sender.object!.isEqual(pwdText)
        if (!userText.text!.isEmpty && !pwdText.text!.isEmpty) {
            self.btn_Login.enabled = true
        } else {
            self.btn_Login.enabled = false
        }
    }

    func loginAuthority(ok: Bool) {
        MBProgressHUD.hideLoadingHUDToView(self.view)
        if ok {
            let jumpCtr = MainTabViewController()
            UIApplication.sharedApplication().delegate!.window!!.rootViewController = jumpCtr
        } else {
            MBProgressHUD.showLoadingErr(self.view, icon: nil)
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
