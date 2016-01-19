//
//  PlayerView.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/29.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class PlayerView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var mp3url: String!
    var playBtn: UIButton!
    var playSlider: UISlider!
    var playOrStopFlag = 0;
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rebuil()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rebuil() {
        self.playSlider = UISlider(frame: CGRectMake(0, self.frame.height / 2, self.frame.width * 0.7, 50))
        self.playSlider.minimumValue = 0;
        self.playSlider.maximumValue = 1;
        self.playSlider.value = 0;
        self.addSubview(self.playSlider)
        
        self.playBtn = UIButton(frame: CGRectMake(self.frame.width * 0.7 - 30, self.frame.height / 2, self.frame.width * 0.3, 50))
        let img = UIImage(named: "Play_32px")
        self.playBtn.setImage(UIImage(data: UIImagePNGRepresentation(img!)!, scale: 1.5), forState: .Normal)
        self.playBtn.addTarget(self, action: "playOrStop", forControlEvents: .TouchUpInside)
        
        self.addSubview(self.playBtn)
    }
    
    func playOrStop() {
        if (playOrStopFlag == 0) {
            self.playBtn.setImage(UIImage(named: "Stop_32px"), forState: .Normal)
            playOrStopFlag = 1
        } else {
            self.playBtn.setImage(UIImage(named: "Play_32px"), forState: .Normal)
            playOrStopFlag = 0
        }
    }
}
