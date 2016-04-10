//
//  CourseForPaperViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class CourseForPaperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        self.view.layer.opacity = 0.3
        
        var label = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: self.view.frame.height))
        label.backgroundColor = UIColor.blackColor()
        self.view.addSubview(label)
        let ges = UITapGestureRecognizer(target: self, action: #selector(self.close(_:)))
        self.view.addGestureRecognizer(ges)
        
        var transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 1.0
        transition.subtype = kCATransitionFromLeft
        transition.type = kCATransitionMoveIn
        transition.removedOnCompletion = false
        self.view.layer.addAnimation(transition, forKey: "yes")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(sender: UITapGestureRecognizer){
        let point = sender.locationInView(self.view)
        print(point);
        if (point.x > 370) {
            UIView.animateWithDuration(1.0, animations: {
                self.view.frame.origin.x = -414
                }, completion: { (bool) in
                    self.willMoveToParentViewController(nil)
                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
            })

        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
