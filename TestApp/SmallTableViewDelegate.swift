//
//  SmallTableViewDelegate.swift
//  TestApp
//
//  Created by Gatsby on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class SmallTableViewDelegate: UIViewController{
    
    var smalltblView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        
        smalltblView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width - 100, UIScreen.mainScreen().bounds.height), style: UITableViewStyle.Plain)
        
        //smalltblView?.bounces = false
        smalltblView?.scrollEnabled = false
        smalltblView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "testcell")
        
        self.view.addSubview(smalltblView!);
//        smalltblView!.delegate = self
//        smalltblView!.dataSource = self
        
        
        let animation = CATransition()
        animation.duration = 0.3
        animation.fillMode = kCAFillModeForwards
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft

        self.view.layer.addAnimation(animation, forKey: "anim");
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(close(_:)))
        self.view.addGestureRecognizer(ges);
    }
    
    func close(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(self.view)
        if (point.x > self.view.frame.width - 100) {
            UIView.animateWithDuration(1, animations: {
                self.view.frame.origin.x = -414
                }, completion: { (t) in
                    self.willMoveToParentViewController(nil)
                    self.view.removeFromSuperview();
                    self.removeFromParentViewController()
            })

        }
    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 15
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        //let cell = tableView.dequeueReusableCellWithIdentifier("testcell",forIndexPath: indexPath)
//        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "testcell")
//        cell.textLabel?.text = "hello"
//        return cell
//    }

}
