//
//  MainTabViewController.swift
//  TestApp
//
//  Created by pzyyll on 15/12/25.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func loadView() {
        super.loadView()
        
        self.tabBar.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
        //self.tabBar.setItems(items, animated: true)
        
        
        //试题界面
        let paperSB = UIStoryboard(name: "PapersStoryboard", bundle: nil)
        
        let messages = paperSB.instantiateViewControllerWithIdentifier("papers") as! PapersViewController
        let navMessages = UINavigationController(rootViewController: messages)
        var img = UIImage(named: "Icon_home_paperSmall");
        
        navMessages.tabBarItem.image = img
        navMessages.tabBarItem.title = "试卷";
        
        
        //练习界面
        let test = TestSearchViewController()
        let navTest = UINavigationController(rootViewController: test)
        img = UIImage(named: "icon_home_practice");
        navTest.tabBarItem.image = img
        test.tabBarItem.title = "练习"
        
        //fun界面
        let me = SelfInforViewController()
        let navMe = UINavigationController(rootViewController: me)
        img = UIImage(named: "alien")
        navMe.tabBarItem.image = img
        navMe.tabBarItem.title = "Fun"
        
        
        self.setViewControllers([navTest, navMessages, navMe], animated: true)
        self.selectedIndex = 0;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
