//
//  CourseForPaperViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/4/9.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

private let ChoiceIndex = "\(identifier_Keychain)setCourses"


class CourseForPaperViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CourseBLDelegate {

    var label: UILabel!
    var tableView: UITableView!
    
    var course: [String: [Course]]!
    var keys: [String]!
    
    var courseBL: CourseBL!
    
    class var shareInstance: CourseForPaperViewController {
        struct Static {
            static var instance: CourseForPaperViewController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CourseForPaperViewController()
        }
        
        return Static.instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        
        self.course = [String: [Course]]()
        self.keys = [String]()
        self.courseBL = CourseBL()
        self.courseBL.delegate = self
        self.courseBL.getAllCourseDict()
        
        self.tableView = UITableView(frame: CGRectMake(0, 64, self.view.frame.width - 100, self.view.frame.height - NavHeight.cgFloat - TabFooterHeight.cgFloat), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        let ges = UITapGestureRecognizer(target: self, action: #selector(self.close(_:)))
        let viewTouch = UIView(frame: CGRectMake(self.tableView.frame.width, self.tableView.frame.origin.y, 100, self.tableView.frame.height))
        viewTouch.addGestureRecognizer(ges)
        self.view.addSubview(viewTouch)
        
        let animation = CATransition()
        animation.duration = 0.3
        animation.fillMode = kCAFillModeForwards
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft
        
        self.tableView.layer.addAnimation(animation, forKey: "smaview")
        let animation2 = CATransition()
        animation2.subtype = kCATransitionFromRight
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        self.view.layer.addAnimation(animation2, forKey: "view")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(sender: UITapGestureRecognizer){
            self.removeFromParentView()
    }
    
    func removeFromParentView() {
        UIView.animateWithDuration(1.0, animations: {
            self.view.backgroundColor = UIColor.clearColor()
            self.tableView.frame.origin.x = -414
            }, completion: { (bool) in
                self.willMoveToParentViewController(nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
        let pCtr = self.parentViewController as! PapersViewController
        pCtr.courseViewOC = !pCtr.courseViewOC
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course[keys[section]]!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return course.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "coursecell"
        
        tableView.rowHeight = 29
        tableView.registerNib(UINib(nibName: "TSCourseTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TSCourseTableViewCell
        cell.titleLableForCourse.text = course[keys[indexPath.section]]![indexPath.row].c_Intro
        
        
        let index = NSUserDefaults.standardUserDefaults().valueForKey(ChoiceIndex) as? [Int]
        if index != nil {
            if index![0] == indexPath.section && index![1] == indexPath.row {
                cell.statusImg = 1
            }
        }
        cell.setStatusImg()

        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = NSUserDefaults.standardUserDefaults().valueForKey(ChoiceIndex) as? [Int]
        if index != nil {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index![1], inSection: index![0])) as! TSCourseTableViewCell
            cell.statusImg = 0
        }
        NSUserDefaults.standardUserDefaults().setValue([indexPath.section, indexPath.row], forKey: ChoiceIndex)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TSCourseTableViewCell
        cell.statusImg = 1
        self.tableView.reloadData()
        
        let c = self.course[keys[indexPath.section]]![indexPath.row]
        NSNotificationCenter.defaultCenter().postNotificationName(CourseChange, object: c)
        
        NSUserDefaults.standardUserDefaults().setValue([c.c_No, c.c_Intro], forKey: DefaultCourse)
        
        self.removeFromParentView()
        //cell.selectedCourseImg.highlighted = true
        //self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func getCoursesDictFinished(courses: [String: [Course]]) {
        dispatch_async(dispatch_get_main_queue()) {
            self.course = courses
            for (key, _) in courses {
                self.keys.append(key)
                self.course[key]!.sortInPlace({ (a, b) -> Bool in
                    return a.c_Intro < b.c_Intro
                })
            }
            self.tableView.reloadData()
        }
    }
    func loadingCoursesFail(fail: Bool) {
        MBProgressHUD.showDelayHUDToView(self.view, mess: "network err", icon: "Icon_err1")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y < 0)
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row >= self.course[keys[indexPath.section]]!.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.tableView.frame.width - 8)
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
