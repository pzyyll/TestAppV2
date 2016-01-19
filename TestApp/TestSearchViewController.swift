//
//  TestSearchViewController.swift
//  TestApp
//
//  Created by pzyyll on 15/12/25.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TestSearchViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {

    var searchTestContentTableView: UITableView!
    var bgNav: UIView!
    var papersList: UITableView!
    var aCell = "aExam"
    var aCourse = Course()
    var examPapers = [ExamPaper]()
    
    override func loadView() {
        super.loadView()
        aCourse.courseNo = "20015LV4"
        aCourse.courseName = "大学英语四级"
        aCourse.courseIntro = "2015-12-26 00:00:00"
        
        self.title = aCourse.courseName
        self.navigationController?.title = "Test"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 88/255, green: 195/255, blue: 224/255, alpha: 1)
        
        //search Btn
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchTest:"))
        searchBtn.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = searchBtn
        
        //table list view
        self.papersList = UITableView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.view.frame.height - 64))
        self.view.addSubview(self.papersList!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        getExamPapers();
        
        //config papersList view
        self.papersList.delegate = self
        self.papersList.dataSource = self
        self.papersList.registerClass(UITableViewCell.self, forCellReuseIdentifier: aCell)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchTest (sender: UIBarButtonItem) {
        
    }

    func getExamPapers() {
        Alamofire.request(.POST, "http://localhost/ios/exam/getExam.php", parameters: ["courseNo": aCourse.courseNo]).response { (requset, Response, data, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let jsonObj = JSON(data: data!);
                //print(jsonObj);
                var curExams = [ExamPaper]()
                if (jsonObj["1"] != nil) {
                    for aExam in jsonObj["1"].array! {
                        let temp = ExamPaper()
                        temp.NO = aExam["ep_No"].string!
                        temp.name = aExam["ep_Name"].string!
                        temp.addTime = aExam["ep_AppdendTime"].string!
                        curExams.append(temp)
                        print(temp.name)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.examPapers = curExams
                    self.examPapers.sortInPlace(self.sortDate)
                    self.papersList.reloadData()
                })
            }
        }
    }
    
    //uitableview data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examPapers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: aCell)
        
        let data = self.examPapers[indexPath.row]
        
        cell.textLabel?.text = data.name
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let makeView = MakeTestViewController()
        makeView.testExamPaper = self.examPapers[indexPath.row]
        self.navigationController?.pushViewController(makeView, animated: true)
    }
    
    //按试卷添加时间排序
    func sortDate(m1: ExamPaper!, m2: ExamPaper!) -> Bool {
        let formDate = NSDateFormatter()
        formDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let m1Date = formDate.dateFromString(m1.addTime)
        let m2Date = formDate.dateFromString(m2.addTime)
        if m1Date!.timeIntervalSince1970 >
            m2Date!.timeIntervalSince1970 {
                return true
        } else {
            return false
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
