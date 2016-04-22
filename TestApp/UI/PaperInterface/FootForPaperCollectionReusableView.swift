//
//  FootForPaperCollectionReusableView.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/20.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class FootForPaperCollectionReusableView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.grayLightColor237()
    }
    
    override func drawRect(rect: CGRect) {
        let p = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, 1))
        UIColor.redColor().setFill()
        p.fill()
    }
}
