//
//  MyDetailViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/5.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

protocol AbsViewFactoryDelegete {
    func createControl(titles: [String]?
        , action: Selector, sender: AnyObject?,
          otherConfig items: [String: AnyObject]!) -> UIView
    
}

extension AbsViewFactoryDelegete {
    func create() -> UIViewController {
        return UIViewController()
    }
}

class AbsViewFactory: AbsViewFactoryDelegete {
    
    var viewFactory: AbsViewFactoryDelegete!
    
    func createControl(titles: [String]?, action: Selector,
                       sender: AnyObject?, otherConfig items: [String:AnyObject]!) -> UIView {
            return viewFactory.createControl(titles, action: action, sender: sender, otherConfig: items)
    }
    init (FactoryType aFactory: AbsViewFactoryDelegete) {
        self.viewFactory = aFactory
    }
    
    class func getDefaultFrame() -> CGRect {
        return CGRectMake(0, 0, 100, 30);
    }
}


class FactoryForLablePaddingOfSubDetail: AbsViewFactoryDelegete {
    func createControl(titles: [String]?,action: Selector,
                       sender: AnyObject?, otherConfig items: [String:AnyObject]!) -> UIView {
            let label = UILabelPadding();
            label.frame = AbsViewFactory.getDefaultFrame();
            label.textAlignment = .Center;
            label.textColor = UIColor.lightGrayColor()
            //label.backgroundColor = UIColor.redColor()
            label.text = titles![0]
            label.lineBreakMode = .ByWordWrapping
            label.font = UIFont.systemFontOfSize(10)
            let size = UILabelPadding.getTxtSize(label.font, txt: label.text!)
            //size.width += 1
            //size.height += 1
            label.frame.size = size
            print(size)
            return label
    }
}

class FactoryForTextFiledOfLogin: AbsViewFactoryDelegete {
    func createControl(titles: [String]?
        , action: Selector, sender: AnyObject?,
          otherConfig items: [String: AnyObject]!) -> UIView {
        let textFiled = TSUITextField(frame: AbsViewFactory.getDefaultFrame());
        textFiled.clearButtonMode = .WhileEditing
        textFiled.autocorrectionType = .No
        textFiled.autocapitalizationType = .None
        textFiled.placeholder = titles![0];
        if let str = items["leftView"] as? String {
            textFiled.leftView = UIImageView(image: UIImage(named: str));
            textFiled.leftViewMode = .Always
        }
        
        if let color = items[TSUITextField.BottomLineColorOfNormal] as? UIColor {
            textFiled.setBottomLineColor(color, state: .Normal)
        }
        if let color = items[TSUITextField.BottomLineColorOfSelected] as? UIColor {
            textFiled.setBottomLineColor(color, state: .Selected)
        }
        
        return textFiled
    }
}

class FactoryForBtnOfNormal: AbsViewFactoryDelegete {
    func createControl(titles: [String]?, action: Selector, sender: AnyObject?, otherConfig items: [String: AnyObject]!) -> UIView {
        let btn = UIButton(frame: AbsViewFactory.getDefaultFrame())
        btn.setTitle(titles![0], forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        btn.userInteractionEnabled = true
        
        if let str = items["bgImg_Normal"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Normal)
        }
        if let str = items["bgImg_Clicked"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Highlighted)
        }
        if let str = items["bgImg_Disabled"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Disabled)
        }
        
        if (action != nil) {
            btn.addTarget(sender, action: action, forControlEvents: .TouchUpInside)
        }
        return btn;
    }

}

class FactoryForBtnOfBorder: AbsViewFactoryDelegete {
    func createControl(titles: [String]?, action: Selector, sender: AnyObject?, otherConfig items: [String : AnyObject]!) -> UIView {
        let btn = UIButton(frame: AbsViewFactory.getDefaultFrame())
        btn.setTitle(titles![0], forState: .Normal)
        btn.setTitleColor(UIColor.orangeColorV1(), forState: .Normal)
        btn.backgroundColor = UIColor.clearColor()
        btn.layer.borderWidth = 1.2
        btn.layer.borderColor = UIColor.orangeColorV1().CGColor
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        
        if let str = items["bgImg_Normal"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Normal)
        }
        if let str = items["bgImg_Clicked"] as? String {
            btn.setBackgroundImage(UIImage(named: str), forState: .Highlighted)
        }
        if action != nil {
            btn.addTarget(sender, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
}
