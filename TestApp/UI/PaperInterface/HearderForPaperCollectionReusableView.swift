//
//  HearderForPaperCollectionReusableView.swift
//  TestApp
//
//  Created by caizhili on 16/4/20.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class HearderForPaperCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setTitleDate(str: String) {
        let dateForm = NSDateFormatter()
        dateForm.dateFormat = "yyyyMMdd"
        let date = dateForm.dateFromString(str)
        dateForm.dateFormat = "yyyy年dd月"
        
        self.title.text = dateForm.stringFromDate(date!)
    }
    
}
