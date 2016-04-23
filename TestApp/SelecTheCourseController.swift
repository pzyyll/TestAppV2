//
//  SmallTableViewDelegate.swift
//  TestApp
//
//  Created by Gatsby on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

protocol SelectTheCourseControllerDataSource {
    func changeData() -> [CourseEntity]?
}


class SelectTheCourseController: UIViewController, UITableViewDelegate, UITableViewDataSource,CourseBLDelegate {
    
    var smalltblView:UITableView?
    
    var rec_courseArr:[Dictionary<String, String>] = []
       /* ["c_No":"c00001","c_Name":"CET-4", "c_Introduction":"大学英语四级","c_AppdendTime":"2016-04-05 14:21:42","l_No":"00001"],
        ["c_No":"c00002","c_Name":"CET-6", "c_Introduction":"大学英语六级","c_AppdendTime":"2016-04-05 14:21:42","l_No":"00001"]]*///,["c_No":"c2","c_Name":"CET-6"],["c_No":"c3", "c_Name":"CET-8"],["c_No":"c4","c_Name":"TEM-4"],["c_No":"c5","c_Name":"TEM-6"]]
    var blankArr : [Dictionary<String, String>] = []
    var dataSourceDelegate: SelectTheCourseControllerDataSource!
    var pendingarr: [CourseEntity]!
    var allCourse: [Course] = []
    var count = 0;
    var appDelegate:AppDelegate!
    let entityName = "CourseEntity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        json_Action()
        
        count += 1;
        
        self.pendingarr = dataSourceDelegate.changeData()
        cout(self.pendingarr)
        
        
        smalltblView = UITableView(frame: CGRectMake(0, 60, UIScreen.mainScreen().bounds.width - 100, UIScreen.mainScreen().bounds.height), style: UITableViewStyle.Plain)
        
        //smalltblView?.bounces = false
        //smalltblView?.scrollEnabled = false
        smalltblView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "testcell")
        smalltblView!.registerNib(UINib(nibName: "CutsomCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "cutsomStyle")
        self.view.addSubview(smalltblView!);
        smalltblView!.delegate = self
        smalltblView!.dataSource = self
        smalltblView!.separatorStyle = UITableViewCellSeparatorStyle.None
        
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
        
        let ges = UITapGestureRecognizer(target: self, action:#selector(close(_:)))
        
        let view = UIView(frame: CGRectMake(smalltblView!.frame.width, smalltblView!.frame.origin.y, 100, smalltblView!.frame.height));
        view.backgroundColor = UIColor.clearColor();
        self.view.addSubview(view)
        view.addGestureRecognizer(ges);
    }
    
    func json_Action(){
        let courseBL = CourseBL()
        courseBL.delegate = self
        courseBL.getAllCourse()
    }
    
    func do_coredata(){
        self.appDelegate = (UIApplication.sharedApplication().delegate) as!  AppDelegate
        
        for i in 0..<self.rec_courseArr.count{
            let rec_course = Course()
            rec_course.c_No = self.rec_courseArr[i]["c_No"]!
            rec_course.c_Name = self.rec_courseArr[i]["c_Name"]!
            rec_course.c_Intro = self.rec_courseArr[i]["c_Introduction"]!
            
            self.allCourse.append(rec_course)
        }
        
    }
    
    func close(sender: UITapGestureRecognizer) {
        //print("in close count \(self.pendingarr.count)");
        
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
                    
                    
                    //self.deleteAllin_coredata() //删除所有 coredata 的数据
                    
                    let parCtr = (self.parentViewController as! PractiseViewController)
                    parCtr.arr = self.pendingarr
                    parCtr.collectionView?.reloadData()
                    print(self.pendingarr.count)
                    
                    self.willMoveToParentViewController(nil)
                    self.view.removeFromSuperview();
                    self.removeFromParentViewController()
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.smalltblView?.deselectRowAtIndexPath(indexPath, animated: true)
        let course = self.allCourse[indexPath.row]
        //print("pendingarr find index: \(findCourse(course))")
        //print("index : \(indexPath.row)")
        if (findCourse(course) < 0) {
            
            insertIn_coredata(course)//如果没有找到, 加一个
            
        } else {
            
            deleteSpecific_coredata(course)
            
        }
        
        //print(indexPath.row)
    }
    
    func insertIn_coredata(course:Course) -> Bool{
        
        if fetchall_coredata(course) {
            return false
        }else{
            
            do{
                let myevent = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: appDelegate.managedObjectContext) as! CourseEntity
                
                myevent.c_No = course.c_No
                myevent.c_Name = course.c_Name
                myevent.c_Introduction = course.c_Intro
                myevent.c_IntroEn = course.c_IntroEn
                
                try self.appDelegate.managedObjectContext.save()
                self.pendingarr.append(myevent)
            }catch let err as NSError{
                print("增加出错\(err)")
            }
            
            return true
        }
    }
    
    func fetchall_coredata(course:Course) -> Bool{
        
        let fetch_No = course.c_No
        let fetchReq = NSFetchRequest(entityName: entityName)
        let findtheNo = NSPredicate(format: "c_No == %@", fetch_No)
        fetchReq.predicate = findtheNo
        
        do{
            let hadFound = try self.appDelegate.managedObjectContext.executeFetchRequest(fetchReq)
            if hadFound.count > 0{
                return true //find the course already had
            }else{
                return false //find zero in the course
            }
        }catch let err as NSError{
            print("查找时出错 \(err)")
            return false
        }
        
    }
    
    func deleteSpecific_coredata(course:Course) -> Bool{
        
        if fetchall_coredata(course){
            //delete coredata data
            let fetch_No = course.c_No
            let fetchReq = NSFetchRequest(entityName: entityName)
            let findtheNo = NSPredicate(format: "c_No == %@", fetch_No)
            fetchReq.predicate = findtheNo
            
            do{
                let hadFound = try self.appDelegate.managedObjectContext.executeFetchRequest(fetchReq)
                print("fetchrequst have \(hadFound.count)")
                if hadFound.count > 0{
                    let needeleted = hadFound[0] as! CourseEntity
                    self.appDelegate.managedObjectContext.deleteObject(needeleted)
                    self.pendingarr.removeAtIndex(findCourse(course));
                    try self.appDelegate.managedObjectContext.save()
                    return true //find the course already had
                }else{
                    return false //find zero in the course
                }
            }catch let err as NSError{
                print("查找 或 删除 时出错 \(err)")
                return false
            }
            
        }else{
            return false
        }
    }
    
    func deleteAllin_coredata(){
        
        let context = appDelegate.managedObjectContext
        let coord = appDelegate.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
            try self.appDelegate.managedObjectContext.save()
        } catch let error as NSError {
            debugPrint(error)
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCourse.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cutsomStyle",forIndexPath: indexPath) as! CutsomCourseTableViewCell
        
        cell.courseNameLabel.text = allCourse[indexPath.row].c_Intro
        
        if(findCourse(self.allCourse[indexPath.row]) != -1){
            let img = UIImage(named: "checked_green")?.imageWithRenderingMode(.AlwaysOriginal)
            cell.currectbtn.setImage(img, forState: .Normal)
            cell.selected_flag = true
        }
        
        return cell
    }
    
    func findCourse(course: Course) -> Int {
        var i = 0;
        for item in self.pendingarr {
            if item.c_No == course.c_No {
                print("delete after count: \(self.pendingarr.count)");
                return i;
            }
            i += 1;
        }
        return -1;
    }
    
    func cout(courses: [CourseEntity]){
        for i in courses {
            print(i.c_No!)
            print(i.c_Name!)
            print("=========")
        }
    }
    
    func getCoursesFinished(courses: [Course]) {
        dispatch_async(dispatch_get_main_queue()) {
            self.appDelegate = (UIApplication.sharedApplication().delegate) as!  AppDelegate
            self.allCourse = courses
            self.smalltblView?.reloadData()
        }
    }
    
    func loadingCoursesFail(fail: Bool) {
        if fail {
            print("abc")
        }
    }
    
    
}