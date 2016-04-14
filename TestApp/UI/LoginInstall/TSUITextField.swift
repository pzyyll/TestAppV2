//
//  TSUITextField.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/14.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class TSUITextField: UITextField {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
    var bottomLine: UIView!
    
    init(){
        super.init(frame: CGRectMake(0, 0, 100, 30));
        
        self.font = UIFont.systemFontOfSize(10)
        self.borderStyle = .None
        
        self.bottomLine = UIView(frame: CGRectMake(0, self.frame.height - 1, self.frame.width, 1));
        self.bottomLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(self.bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 20, 2)
    }
}
