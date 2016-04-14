//
//  PapersViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/3/31.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class PapersViewController: UIViewController {

    @IBOutlet weak var t: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = UIButton(type: .Custom)
        a.frame = CGRect(x: 80, y: 80, width: 100, height: 150)
        a.setBackgroundImage(UIImage(named: "bg_paper_latest_pressed"), forState: .Highlighted)
        a.setBackgroundImage(UIImage(named: "bg_paper_latest"), forState: .Normal)
        
        let label = UILabel(frame: CGRect(x: 10, y: 50, width: a.frame.width, height: 20))
        label.font = UIFont.systemFontOfSize(20)
        label.text = "abcd"
        label.textColor = UIColor.blackColor()
        a.addSubview(label)

        self.view.addSubview(a)
        a.addTarget(self, action: #selector(self.pushView), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pushView(){
        let viewCtr = CourseForPaperViewController()
        self.addChildViewController(viewCtr)
        self.view.addSubview(viewCtr.view)
        viewCtr.didMoveToParentViewController(self)
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
