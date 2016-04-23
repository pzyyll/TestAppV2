//
//  PapersViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/3/31.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

let CourseChange = "coursechange"

class PapersViewController: UIViewController, PaperBLDelegate, TSPaperCollectionViewDelegate {

    @IBOutlet weak var left: UIBarButtonItem!
    @IBOutlet weak var switchTM: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    
    var courseViewOC = true
    var courseCtr: CourseForPaperViewController!
    var courseb: Course!
    var paperBL: PaperBL!
    
    var papers: [String: [ExamPaper]]!
    
    var collectionView: TSPaperCollectionView!
    
    var tview: LoadingAnmationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.courseChange(_:)), name: CourseChange, object: nil)
        self.configView()
        
        tview = LoadingAnmationView(frame: CGRectMake(100,100,30, 40))
        //self.view.addSubview(tview)
       
        print("viewdidload\(switchTM.selectedSegmentIndex)")
        self.paperBL = PaperBL()
        self.paperBL.delegate = self
        self.courseb = Course.getCoursesDefault()
        self.titleLabel.text = self.courseb.c_Intro
        self.paperBL.getAllPapers(self.courseb, type: switchTM.selectedSegmentIndex + 1)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func configView() {
        self.view.backgroundColor = UIColor.grayLightColor237()
        self.switchTM.frame.size.height -= 10
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 120
        layout.itemSize.width = 90
        layout.headerReferenceSize = CGSizeMake(0, 37)
        layout.footerReferenceSize = CGSizeMake(0, 10)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 30, bottom: 20, right: 30)
        collectionView = TSPaperCollectionView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height - 59 - 44), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegateData = self
        self.view.addSubview(collectionView)
    }

    @IBAction func switchTypeForPaper(sender: UISegmentedControl) {

        MBProgressHUD.showLoadingHUDToView(self.view, icon: nil)
        self.paperBL.getAllPapers(self.courseb, type: switchTM.selectedSegmentIndex + 1)
        //self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setCourse(sender: UIBarButtonItem) {
        //self.presentViewController(, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        if courseViewOC {
            self.courseCtr = CourseForPaperViewController()
            self.addChildViewController(courseCtr)
            self.view.addSubview(courseCtr.view);
            self.didMoveToParentViewController(self)
        } else {
            courseCtr.removeFromParentView()
        }
        courseViewOC = !courseViewOC
    }
    
    func getAllPapersFinished(papersDict: [String: AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) {
            self.papers = papersDict as! [String: [ExamPaper]]
            self.collectionView.reloadData()
            if self.papers.count == 0 {
                print(self.view.subviews.count)
                self.view.insertSubview(self.tview, atIndex: 5)
            } else {
                self.tview.removeFromSuperview()
            }
            
            MBProgressHUD.hideLoadingHUDToView(self.view)
        }
    }
    
    func getAllPapersFail(fail: Bool) {
        MBProgressHUD.hideLoadingHUDToView(self.view)
        if fail {
            MBProgressHUD.showDelayHUDToView(self.view, mess: "network is err", icon: "Icon_err2")
        }
    }
    
    func changeData() -> [String: [ExamPaper]]? {
        return self.papers
    }
    
    func courseChange(sender: NSNotification) {
        self.courseb = sender.object as! Course
        MBProgressHUD.showLoadingHUDToView(self.view, icon: nil)
        self.titleLabel.text = courseb.c_Intro
        self.paperBL.getAllPapers(self.courseb, type: self.switchTM.selectedSegmentIndex + 1)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: CourseChange, object: nil)
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
