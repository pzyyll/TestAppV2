//
//  LoginViewController.swift
//  LoginUI
//
//  Created by pzyyll on 15/11/20.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var labelUsername: UILabel!
    var labelPwd: UILabel!
    var textUsername: UITextField!
    var textPwd: UITextField!
    
    override func loadView() {
        super.loadView()
        var rect = CGRectMake(20, 200, 80, 30)
        
        labelUsername = UILabel(frame: rect)
        
        rect.origin = labelUsername.frame.origin
        rect.origin.x += labelUsername.frame.width + 20
        rect.size.width = 200
        textUsername = UITextField(frame: rect)
        

        rect.origin = labelUsername.frame.origin
        rect.origin.y += labelUsername.frame.height + 10
        rect.size = labelUsername.frame.size
        labelPwd = UILabel(frame: rect)
        
        
        rect.origin = labelPwd.frame.origin
        rect.origin.x = textUsername.frame.origin.x
        rect.size = textUsername.frame.size
        textPwd = UITextField(frame: rect)
        

        
        
//        self.view.addSubview(labelUsername)
//        self.view.addSubview(labelPwd)
//        self.view.addSubview(textUsername)
//        self.view.addSubview(textPwd)
        
        let viewFactory = AbsViewFactory(FactoryType: FactoryForTextFiledOfLogin());
        
        let userText = viewFactory.createControl(nil, action: nil, sender: nil, otherConfig: ["Icon_login_user"]);
        userText.translatesAutoresizingMaskIntoConstraints = false
        userText.frame.size.width = 300;
        userText.frame.size.height = 30;
        self.view.addSubview(userText)
        
        let cons1 = NSLayoutConstraint.constraintsWithVisualFormat("[tView(==\(userText.frame.width))]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["tView": userText])
        let cons2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[tView(==\(userText.frame.height))]", options: .AlignAllTop, metrics: nil, views: ["tView": userText]);
        NSLayoutConstraint.activateConstraints(cons1)
        NSLayoutConstraint.activateConstraints(cons2)
        NSLayoutConstraint(item: userText, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0).active = true
        
        let pwdText = viewFactory.createControl(nil, action: nil, sender: nil, otherConfig: ["Icon_login_pwd"]);
        pwdText.translatesAutoresizingMaskIntoConstraints = false
        pwdText.frame.size.width = userText.frame.width
        pwdText.frame.size.height = userText.frame.height
        self.view.addSubview(pwdText)
        print(pwdText.frame)
        
        let cons3 = NSLayoutConstraint.constraintsWithVisualFormat("V:[userText]-4-[pwdText(==\(pwdText.frame.height))]", options: .AlignAllLeft, metrics: nil, views: ["userText": userText, "pwdText": pwdText])
        let cons4 = NSLayoutConstraint.constraintsWithVisualFormat("H:[pwdText(==\(pwdText.frame.width))]", options: .AlignAllTop, metrics: nil, views: ["pwdText": pwdText])
        NSLayoutConstraint.activateConstraints(cons3)
        NSLayoutConstraint.activateConstraints(cons4)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242, green: 242, blue: 242, alpha: 1)
        
        //labelUsername.text = "User Name"
        labelUsername.textColor = UIColor.blackColor()
        labelUsername.textAlignment = NSTextAlignment.Right
        labelUsername.font = UIFont.systemFontOfSize(15)
        
        
        //labelPwd.text = "Passwd"
        labelPwd.textColor = UIColor.blackColor()
        labelPwd.textAlignment = NSTextAlignment.Right
        labelPwd.font = UIFont.systemFontOfSize(15)
        
        textUsername.borderStyle = .RoundedRect
        textUsername.placeholder = "Please enter user name"
        textUsername.returnKeyType = .Next
        textUsername.clearButtonMode = UITextFieldViewMode.WhileEditing
        textUsername.delegate = self
        textUsername.leftView?.bounds.size.width -= 10;
        textUsername.leftView?.bounds.size.height -= 10;
        textUsername.leftViewMode = .Always
        
        textPwd.borderStyle = UITextBorderStyle.RoundedRect
        textPwd.returnKeyType = .Done
        textPwd.clearButtonMode = .WhileEditing
        textPwd.delegate = self
        textPwd.secureTextEntry = true
        textPwd.leftViewMode = .Always
        textPwd.leftView?.bounds.size.width -= 3
        textPwd.leftView?.bounds.size.height -= 3
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textUsername.resignFirstResponder()
        textPwd.resignFirstResponder()
        return true;
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //change the login button states
        
        return true
    }
    

    func textFieldShouldClear(textField: UITextField) -> Bool {
    
        return true
    }
    
    func login() {
        print("it's login");

        if textUsername.text == "czl" && textPwd.text == "123456789" {
            let segView = MainTabViewController()
            self.presentViewController(segView, animated: true, completion: nil)
        } else {
            let alertView = UIAlertController(title: "Warn", message: "用户名或密码错误", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        }
    }
    
    func register(sender: UIButton) {
        print("it's register")
        
        let reg = RegisterViewController()
        reg.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(reg, animated: true, completion: nil)
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
