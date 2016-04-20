//
//  CustomCLcell.swift
//  CutsomLayout
//
//  Created by Gatsby on 16/3/28.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

class CustomCLcell : UICollectionViewCell{
    let width = UIScreen.mainScreen().bounds.size.width//获取屏幕宽
    var imgView : UIImageView?
    var nameLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        rebuildCellInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rebuildCellInterface(){
        
        imgView = UIImageView(frame: CGRectMake(0, 0, 40, 40))//80 80
        imgView?.layer.cornerRadius = (imgView?.frame.width)! / 2
        imgView?.layer.borderWidth = 1
        imgView?.layer.borderColor = UIColor.grayColor().CGColor
        self.addSubview(imgView!)
        
        nameLabel = UILabel(frame: CGRectMake(self.frame.width/2-25, self.frame.height - 20, 60, 20))
        //nameLabel?.backgroundColor = UIColor.purpleColor()
        self.addSubview(nameLabel!)
        
        
    }
    
    func toggleSelected ()
    {
//        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: {
//            //self.layer.backgroundColor = UIColor.orangeColor().CGColor
//            
//        }) { (finsh) in
//              //  self.layer.backgroundColor = UIColor.whiteColor().CGColor
//            //self.imgView = UIImageView(image: UIImage(named:"icon.png"))
//        }

        UIView.animateKeyframesWithDuration(0.2, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: {
            //self.layer.backgroundColor = UIColor.grayColor().CGColor
            self.imgView?.backgroundColor = UIColor.grayColor()
        }) {
            (finsh) in
            
        UIView.animateKeyframesWithDuration(0.2, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: {
                //self.layer.backgroundColor = UIColor.whiteColor().CGColor
            self.imgView?.backgroundColor = UIColor.clearColor()
                }, completion: nil)
            
        }
        
//        if (selected){
//            backgroundColor = UIColor.orangeColor()
//        }else {
//            backgroundColor = UIColor.whiteColor()
//        }
    }
    
    

    func untoggleSelected(){
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: {
            self.layer.backgroundColor = UIColor.whiteColor().CGColor
            }, completion: nil)
    }
    
//    override var selected: Bool{
//        didSet {
//            if self.selected{
//                self.highlighted = true
//            }else{
//                //backgroundColor = UIColor.whiteColor()
//            }
//        }
//    }
    
}
