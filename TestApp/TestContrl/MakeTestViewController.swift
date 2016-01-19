//
//  MakeTestViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MakeTestViewController: UIViewController, MyTableViewContrlerDelegate {

    var testExamPaper: ExamPaper?
    var theTestPaper : AExamPaper?
    
    var contentView: UIScrollView!

    var needDisplayNum = 0
    var allTopicNum = 0
    var allTopicDetail = [TopicDetail]()
    var timeBtn: UIBarButtonItem!
    var timer = Timer()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        //去掉scorllview自动填充64
        self.automaticallyAdjustsScrollViewInsets = false
        //test
        
        //init content View
        self.contentView = UIScrollView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height - 64))
        self.contentView.pagingEnabled = true
        //获取试卷信息
        getExamPapers2();
        //sleep(3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //返回按钮
        self.tabBarController!.tabBar.hidden = true
        var img = UIImage(named: "back")
        let backBtn = UIBarButtonItem(image: UIImage(data: UIImagePNGRepresentation(img!)!, scale: 5.0), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        backBtn.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        backBtn.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = backBtn
        
        img = UIImage(named: "start")
        let startBtn = UIBarButtonItem(image: UIImage(data: UIImagePNGRepresentation(img!)!, scale: 1.8), style: .Plain, target: self, action: "start")
        startBtn.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = startBtn
        
        img = UIImage(named: "List")
        let listBtn = UIBarButtonItem(image: UIImage(data: UIImagePNGRepresentation(img!)!, scale: 1.8), style: .Plain, target: self, action: "listCommit")
        listBtn.tintColor = UIColor.whiteColor()
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        self.timeBtn = UIBarButtonItem(title: "00:00", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.timeBtn.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItems = [startBtn, spaceBtn, self.timeBtn, spaceBtn,listBtn, spaceBtn]
        // Do any additional setup after loading the view.

        
        self.needDisplayNum = getNeedDisplayNum(self.theTestPaper!)
        print(self.needDisplayNum)
        self.contentView.contentSize = CGSizeMake(self.contentView.frame.width * CGFloat(self.needDisplayNum), self.contentView.frame.height)
        self.allTopicNum = getAllTopicNum(self.theTestPaper!)
        
        setDisplayView()
        self.view.addSubview(self.contentView!)
        //print("no")

    }

    override func viewDidAppear(animated: Bool) {
        //print("yes")
        
        self.timer.timer = NSTimer(timeInterval: 1.0, target: self, selector: "nstimerHandler", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer.timer!, forMode: NSDefaultRunLoopMode)
        self.timer.timer!.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
        self.tabBarController!.tabBar.hidden = false
    }

    //mytableview delegate
    func showAler(view: UIViewController) {
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    func getExamPapers() {

        Alamofire.request(.POST, "http://127.0.0.1/ios/exam/getExamPapaer.php", parameters: ["ep_No": testExamPaper!.NO]).response(completionHandler: { (_, _, data, _) -> Void in
            let jsonObj = JSON(data: data!);
            let paperinfo = jsonObj["1"];
            
            var temp = AExamPaper()
            for (key, value) in paperinfo {
                if (key == "paperNo") {
                    temp.ep_No = value.stringValue
                } else {
                    var onePart = OnePartOfChoice()
                    onePart.intro = value["direction",0,"intro"].stringValue
                    onePart.ansScore = value["direction",0,"ansScore"].stringValue
                    for (key, val) in value["options"] {
                        var atopic = ATopic()
                        atopic.content = val["choice_Content"].stringValue
                        atopic.title = val["choice_Title"].stringValue
                        for (key, val) in val["question"] {
                            var option = OptionItem()
                            
                            option.title = val["co_question"].stringValue
                            option.rights = val["co_Right"].stringValue
                            option.no = val["co_No"].stringValue
                            option.ans = val["co_No"].stringValue
                            option.options!.append(val["co_A"].stringValue)
                            option.options!.append(val["co_B"].stringValue)
                            option.options!.append(val["co_C"].stringValue)
                            option.options!.append(val["co_D"].stringValue)
                            
                            atopic.question.append(option)
                        }
                        
                        onePart.topics.append(atopic)
                    }
                    temp.Choice[key] = onePart
                    print(temp.Choice)
                }
            }
            
//            dispatch_async(dispatch_get_main_queue(), {() -> Void in
//                self.theTestPaper = temp
//            })
            self.theTestPaper = temp
        })
    }
    
    func getExamPapers2() {
    
        let semp = dispatch_semaphore_create(0)
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://127.0.0.1/ios/exam/getExamPapaer.php")
        let task = session.dataTaskWithRequest(NSURLRequest(URL: url!)) { (data, _, _) -> Void in
            let jsonObj = JSON(data: data!);
            let paperinfo = jsonObj["1"];
            
            let temp = AExamPaper()
            for (key, value) in paperinfo {
                if (key == "paperNo") {
                    temp.ep_No = value.stringValue
                } else {
                    let onePart = OnePartOfChoice()
                    onePart.intro = value["direction",0,"intro"].stringValue
                    onePart.ansScore = value["direction",0,"ansScore"].stringValue
                    for (key, val) in value["options"] {
                        let atopic = ATopic()
                        atopic.content = val["choice_Content"].stringValue
                        atopic.title = val["choice_Title"].stringValue
                        for (key, val) in val["question"] {
                            let option = OptionItem()
                            
                            option.title = val["co_question"].stringValue
                            option.rights = val["co_Right"].stringValue
                            option.no = val["co_No"].stringValue
                            option.ans = val["co_No"].stringValue
                            option.options!.append(val["co_A"].stringValue)
                            option.options!.append(val["co_B"].stringValue)
                            option.options!.append(val["co_C"].stringValue)
                            option.options!.append(val["co_D"].stringValue)
                            
                            atopic.question.append(option)
                        }
                        
                        onePart.topics.append(atopic)
                    }
                    temp.Choice[key] = onePart
                    print(temp.Choice)
                }
            }
            
            //            dispatch_async(dispatch_get_main_queue(), {() -> Void in
            //                self.theTestPaper = temp
            //            })
            self.theTestPaper = temp
            dispatch_semaphore_signal(semp)
        }
        task.resume()
        dispatch_semaphore_wait(semp, DISPATCH_TIME_FOREVER)
    }
    
    func getNeedDisplayNum(paper: AExamPaper) -> Int {
        var num = 0;
        
        num += paper.Choice.count
        
        for (_, val) in paper.Choice {
            num += val.topics.count
        }
        
        return num
    }
    
    func getAllTopicNum(paper: AExamPaper) -> Int {
        var num = 0;
        for (_, val) in paper.Choice {
            for topic in val.topics {
                num += topic.question.count
            }
        }
        
        return num
    }
    
    func setDisplayView() {
        let mainRect = self.contentView.frame
        var cnt = 0
        var subCnt = 0
        for (key, val) in self.theTestPaper!.Choice {
            if (val.intro != "") {
                let aDisplay = CustomView(frame: CGRectMake(CGFloat(cnt++) * mainRect.width, 0, mainRect.width, mainRect.height))
                let aSelectView = MyTableView(frame: CGRectMake(0, 0, 0, 0), style: .Plain)
                //print(val.intro)
                aSelectView.dataOption = OptionItem(title: val.intro, options: [String]())
                //print(key)
                aSelectView.setTitleLeftItemText(key)
                aSelectView.setTitleRightItemText(30, rightNum: 12)
                aDisplay.setTitleStyle()
                aDisplay.setSelectTableViews([aSelectView])
                self.contentView.addSubview(aDisplay)
            }
            
            for atopic in val.topics {
                let aDisplay = CustomView(frame: CGRectMake(CGFloat(cnt++) * mainRect.width, 0, mainRect.width, mainRect.height))
                aDisplay.setTextViewText("\(atopic.title)\n\(atopic.content)")
                var optionsView = [MyTableView]()
                for aoption in atopic.question {
                    let aoptionView = MyTableView(frame: self.view.frame, style: .Plain)
                    aoptionView.dataOption = OptionItem(title: aoption.title, options: aoption.options!)
                    aoptionView.setTitleLeftItemText(self.testExamPaper!.name)
                    aoptionView.setTitleRightItemText(++subCnt, rightNum: self.allTopicNum)
                    optionsView.append(aoptionView)
                }
                aDisplay.setSelectTableViews(optionsView)
                
                if (key == "LV4SC" || key == "LV4SP" || key == "LV4LC") {
                    let playView = PlayerView(frame: CGRectMake(20, 36, self.view.frame.width, 30))
                    aDisplay.textView.addSubview(playView)
                }
                
                self.contentView.addSubview(aDisplay)
            }
        }
        
    }
    
    func start() {
        alerShow()
    }
    
    func listCommit() {
        alerShow()
    }
    
    func alerShow() {
        let aler = UIAlertController(title: "", message: "功能还没有实现呢~>_<~ ", preferredStyle: UIAlertControllerStyle.Alert)
        aler.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(aler, animated: true, completion: nil)
    }
    
    
    func nstimerHandler() {
        timer.sec++
        timer.update()
        self.timeBtn.title = "\(self.timer.getHourString()):\(self.timer.getSecString())"
        //self.timer.timer!.fire()
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
