//
//  PapersViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/3/31.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class PapersViewController: UIViewController, CourseBLDelegate {

    @IBOutlet weak var left: UIBarButtonItem!
    @IBOutlet weak var switchTM: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configView()
        
        let tview = LoadingAnmationView(frame: CGRectMake(100,100,30, 40))
        self.view.addSubview(tview)
       
        // Do any additional setup after loading the view.
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
        let collectionView = TSPaperCollectionView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height - 59 - 44), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()

        self.view.addSubview(collectionView)
    }

    @IBAction func switchTypeForPaper(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("a")
        case 1:
            print("b")
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setCourse(sender: UIBarButtonItem) {
        let courseBl = CourseBL()
        courseBl.delegate = self
        courseBl.getAllCourse()
    }
    
    func getCoursesFinished(courses: [Course]) {
        dispatch_async(dispatch_get_main_queue()) {
            print(courses.count)
            print(courses[0].c_Intro)
        }
    }
    
    func loadingCoursesFail(fail: Bool) {
        if fail {
            MBProgressHUD.showDelayHUDToView(self.view, mess: "network is err", icon: "Icon_err2")
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
