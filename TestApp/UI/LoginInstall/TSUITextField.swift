//
//  TSUITextField.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/14.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class TSUITextField: UITextField {
    class var BottomLineColorOfNormal: String {
        return "BottomLineColorOfNormal"
    }
    class var BottomLineColorOfSelected: String {
        return "BottemLineColorOfSelected"
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
    var bottomLine: UIView!
    var bottomLineColorOfNormal: UIColor!
    var bottomLineColorOfSelected: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.height = 30;
        
        self.font = UIFont.systemFontOfSize(10)
        self.borderStyle = .None
        self.bottomLine = UIView(frame: CGRectMake(0, self.frame.height - 1, 1000, 1));
        self.bottomLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(self.bottomLine)
        self.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changeBottomLineColor), name: UITextFieldTextDidBeginEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changeBottomLineColor), name: UITextFieldTextDidEndEditingNotification, object: self)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRectMake(0, 0, 300, 0))
        self.translatesAutoresizingMaskIntoConstraints = false
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.textRectForBounds(bounds)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var res = bounds;
        if (self.leftView != nil) {
            res.origin.x += 28;
            res.size.width -= 44;
        }
        return res
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var res = CGRectMake(4, 0, self.frame.height - 15, self.frame.height - 15)
        //水平居中
        res.origin.y = bounds.height / 2 - res.height / 2;
        return res
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            if (change?[NSKeyValueChangeNewKey]) != nil {
                self.bottomLine.frame = CGRectMake(0, self.frame.height - 1, self.frame.width, 1)
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
        
    }
    
    func changeBottomLineColor() {
        if self.editing {
            self.bottomLine.backgroundColor = self.bottomLineColorOfSelected
        } else {
            self.bottomLine.backgroundColor = self.bottomLineColorOfNormal
        }
    }
    
    func setBottomLineColor(color: UIColor, state: UIControlState){
        switch state {
        case UIControlState.Normal:
            self.bottomLineColorOfNormal = color
        case UIControlState.Selected:
            self.bottomLineColorOfSelected = color
        default:
            break
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "frame")
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidBeginEditingNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidEndEditingNotification, object: nil)
    }
}
