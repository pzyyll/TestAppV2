//
//  LoadingAnmationView.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/21.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class LoadingAnmationView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var img: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.img = UIImageView(frame: frame)
        self.img.animationImages = [UIImage]()
        for i in 1...15 {
            let str = "more_coolsite_\(i)";
            self.img.animationImages?.append(UIImage(named: str)!)
        }
        img.animationDuration = 0.6
        self.addSubview(img)
        
        img.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        img.stopAnimating()
    }

}
