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
        self.title.text = str
    }
    
}
