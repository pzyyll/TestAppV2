//
//  SmallTableViewDelegate.swift
//  TestApp
//
//  Created by Gatsby on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class SelectTheCourseController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var smalltblView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        smalltblView = UITableView(frame: CGRectMake(0, 60, UIScreen.mainScreen().bounds.width - 100, UIScreen.mainScreen().bounds.height), style: UITableViewStyle.Plain)
        
        //smalltblView?.bounces = false
        //smalltblView?.scrollEnabled = false
        smalltblView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "testcell")
        
        self.view.addSubview(smalltblView!);
        smalltblView!.delegate = self
        smalltblView!.dataSource = self
        
        
        let animation = CATransition()
        animation.duration = 0.3
        animation.fillMode = kCAFillModeForwards
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft
        
        //self.view.layer.addAnimation(animation, forKey: "anim");
        smalltblView?.layer.addAnimation(animation, forKey: "smaview")
        let animation2 = CATransition()
        animation2.subtype = kCATransitionFromRight
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.view.layer.addAnimation(animation2, forKey: "view")
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(close(_:)))
        self.view.addGestureRecognizer(ges);
    }
    
    func close(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(self.view)
        if (point.x > self.view.frame.width - 100) {
                let animation3 = CATransition()
                animation3.duration = 0.2
                self.view.backgroundColor = UIColor.clearColor()
                self.view.layer.addAnimation(animation3, forKey: "viewbye")
            
                self.view.backgroundColor = UIColor.clearColor()
            UIView.animateWithDuration(1, animations: {
                
                self.view.frame.origin.x = -414
                }, completion: { (t) in
                    self.willMoveToParentViewController(nil)
                    self.view.removeFromSuperview();
                    self.removeFromParentViewController()
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = tableView.dequeueReusableCellWithIdentifier("testcell",forIndexPath: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "testcell")
        cell.textLabel?.text = "hello"
        return cell
    }

}
