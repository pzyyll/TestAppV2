//
//  CutsomCourseTableViewCell.swift
//  TestApp
//
//  Created by Gatsby on 16/4/14.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class CutsomCourseTableViewCell: UITableViewCell {

   
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if(selected){
        
           if self.backgroundColor == UIColor.greenColor(){
                self.backgroundColor = UIColor.clearColor()
            }else{
                self.backgroundColor = UIColor.greenColor()
            }
        }
        // Configure the view for the selected state
    }
    
}
