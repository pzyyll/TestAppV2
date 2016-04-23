//
//  TSCourseTableViewCell.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/23.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class TSCourseTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedCourseImg: UIImageView!
    @IBOutlet weak var titleLableForCourse: UILabel!
    var statusImg: NSInteger = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addObserver(self, forKeyPath: "statusImg", options: NSKeyValueObservingOptions.New, context: nil)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "statusImg") {
            self.setStatusImg()
        }
    }
    
    func setStatusImg() {
        if self.statusImg == 1 {
            self.selectedCourseImg.image = UIImage(named: "checked_green")
        } else {
            self.selectedCourseImg.image = nil
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "statusImg")
    }
}
