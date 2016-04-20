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
   
    @IBOutlet weak var currectbtn: UIButton!
    
    var selected_flag = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        currectbtn.userInteractionEnabled = false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if(selected){
        
            if selected_flag == false {
                let img = UIImage(named: "checked_green")?.imageWithRenderingMode(.AlwaysOriginal)

                currectbtn.setImage(img, forState: .Normal)
                selected_flag = true
            }else{
                currectbtn.setImage(UIImage(named: ""), forState: .Normal)
                selected_flag = false
            }
            /*
           if self.backgroundColor == UIColor.greenColor(){
                self.backgroundColor = UIColor.clearColor()
            }else{
                self.backgroundColor = UIColor.greenColor()
            }*/
        }
        // Configure the view for the selected state
    }
    
}
