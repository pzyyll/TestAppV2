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
        otherConfig items: [AnyObject]!) -> UIView
    
}

extension AbsViewFactoryDelegete {
    func create() -> UIViewController {
        return UIViewController()
    }
}

class AbsViewFactory: AbsViewFactoryDelegete {
    
    var viewFactory: AbsViewFactoryDelegete!
    
    func createControl(titles: [String]?, action: Selector,
        sender: AnyObject?, otherConfig items: [AnyObject]!) -> UIView {
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
        sender: AnyObject?, otherConfig items: [AnyObject]!) -> UIView {
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
          otherConfig items: [AnyObject]!) -> UIView {
        let textFiled = TSUITextField(frame: AbsViewFactory.getDefaultFrame());
        textFiled.clearButtonMode = .WhileEditing
        if items != nil {
            textFiled.leftView = UIImageView(image: UIImage(named: items[0] as! String));
            textFiled.leftViewMode = .Always
        }
        
        return textFiled
    }
}

class FactoryForBtnOfLogin: AbsViewFactoryDelegete {
    func createControl(titles: [String]?, action: Selector, sender: AnyObject?, otherConfig items: [AnyObject]!) -> UIView {
        let btn = UIButton(frame: <#T##CGRect#>)
    }
}
