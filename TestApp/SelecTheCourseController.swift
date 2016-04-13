//
//  SmallTableViewDelegate.swift
//  TestApp
//
//  Created by Gatsby on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

protocol SelectTheCourseControllerDataSource {
    func changeData() -> [Course]?
}

class SelectTheCourseController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var smalltblView:UITableView?
    
    var dataSourceDelegate: SelectTheCourseControllerDataSource!
    var pendingarr: [Course]!
    var allCourse: [Course]!
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load \(count)");
        count += 1;
        if (NSUserDefaults.standardUserDefaults().valueForKey("TestApp_Course") != nil) {
            var courseFromUserDefault = NSUserDefaults.standardUserDefaults().valueForKey("TestApp_Course") as! [String: [Course]];
            self.pendingarr = courseFromUserDefault["courseList"];
        } else {
            self.pendingarr = dataSourceDelegate.changeData()
            cout(self.pendingarr)
        }
    
        let firstCourse = Course()
        firstCourse.c_No = "c1"
        firstCourse.c_Name = "CET-4";
        let secCourse = Course()
        secCourse.c_No = "c2"
        secCourse.c_Name = "CET-6";
        let thCourse = Course()
        thCourse.c_No = "c3"
        thCourse.c_Name = "CET-8";
        
        self.allCourse = [firstCourse, secCourse, thCourse]
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
        let view = UIView(frame: CGRectMake(smalltblView!.frame.width, smalltblView!.frame.origin.y, 100, smalltblView!.frame.height));
        view.backgroundColor = UIColor.clearColor();
        self.view.addSubview(view)
        view.addGestureRecognizer(ges);
    }
    
    func close(sender: UITapGestureRecognizer) {
        print("in close count \(self.pendingarr.count)");
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
                    let parCtr = (self.parentViewController as! PractiseViewController)
                    parCtr.arr = self.pendingarr
                    parCtr.collectionView?.reloadData()
                    print(self.pendingarr.count)
                    //print(parCtr.arr.count)
                    //var dicArr = ["courseList": self.pendingarr];
                    //NSUserDefaults.standardUserDefaults().setObject(dicArr, forKey: "TestApp_Course")
                    
                    self.willMoveToParentViewController(nil)
                    self.view.removeFromSuperview();
                    self.removeFromParentViewController()
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let course = self.allCourse[indexPath.row]
        print("find index: \(findCourse(course))")
        print("index : \(indexPath.row)")
        if (findCourse(course) < 0) {
            self.pendingarr.append(course)
        } else {
            self.pendingarr.removeAtIndex(findCourse(course));
            print("after count \(self.pendingarr.count)")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCourse.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = tableView.dequeueReusableCellWithIdentifier("testcell",forIndexPath: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "testcell")
        cell.textLabel?.text = allCourse[indexPath.row].c_Name
        
        return cell
    }
    
    func findCourse(course: Course) -> Int {
        var i = 0;
        for item in self.pendingarr {
            print(item.c_No)
            print(course.c_No)
            print("-----------")
            if item.c_No == course.c_No {
                print("delete after count: \(self.pendingarr.count)");
                return i;
            }
            i += 1;
        }
        return -1;
    }

    func cout(courses: [Course]){
        for i in courses {
            print(i.c_No)
            print(i.c_Name)
            print("=========")
        }
    }
    
}
