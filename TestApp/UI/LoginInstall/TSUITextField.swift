//
//  TSUITextField.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/14.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

private var mycontext = 0;

class TSUITextField: UITextField {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
    var bottomLine: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.height = 30;
        
        self.font = UIFont.systemFontOfSize(10)
        self.borderStyle = .None
        
        self.bottomLine = UIView(frame: CGRectMake(0, self.frame.height - 1, self.frame.width, 1));
        self.bottomLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(self.bottomLine)
        
        self.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: &mycontext);
        
    }
    
//    init(){
//        super.init(frame: CGRectMake(0, 0, 100, 30));
//        
//        self.font = UIFont.systemFontOfSize(10)
//        self.borderStyle = .None
//        
//        self.bottomLine = UIView(frame: CGRectMake(0, self.frame.height - 1, self.frame.width, 1));
//        self.bottomLine.backgroundColor = UIColor.lightGrayColor()
//        self.addSubview(self.bottomLine)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.textRectForBounds(bounds)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var res = bounds;
        res.origin.x += 28;
        res.size.width -= 44;
    
        return res
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var res = CGRectMake(4, 0, self.frame.height - 15, self.frame.height - 15)
        //水平居中
        res.origin.y = bounds.height / 2 - res.height / 2;
        return res
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &mycontext {
            if let newValue = change?[NSKeyValueChangeNewKey] {
                self.bottomLine.frame = CGRectMake(0, self.frame.height - 1, self.frame.width, 1)
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "frame", context: &mycontext);
    }
}
