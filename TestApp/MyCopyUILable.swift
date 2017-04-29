//
//  MyCopyUILable.swift
//  Message
//
//  Created by Gatsby on 16/1/24.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

class MyCopyUILabel : UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.attachTapHandler()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func canBecomeFirstResponder() -> Bool {//成为第一响应
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return (action == #selector(NSObject.copy(_:)))
    }
    
    override func copy(sender: AnyObject?) {
        let pboard = UIPasteboard.generalPasteboard()
        pboard.string = self.text
    }
    
    func attachTapHandler() -> Void{
        self.userInteractionEnabled = true
        let touch = UILongPressGestureRecognizer(target: self, action: #selector(MyCopyUILabel.handlerTap(_:)))
        self.addGestureRecognizer(touch)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.attachTapHandler()
    }
    
    func handlerTap(recognizer:UIGestureRecognizer){
        self.becomeFirstResponder()
        //let copyLink = UIMenuItem(title: "复制", action: Selector("copy:"))
        let menu = UIMenuController()
        //menu.menuItems = [copyLink]
        menu.setTargetRect(self.frame, inView: self.superview!)
        menu.setMenuVisible(true, animated: true)
    }
    
}
