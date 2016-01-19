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
        
        
        //备忘录界面
        let messages = MainViewController()
        let navMessages = UINavigationController(rootViewController: messages)
        var img = UIImage(named: "test");
        navMessages.tabBarItem.image = UIImage(data: UIImagePNGRepresentation(img!)!, scale: 2.0)
        navMessages.tabBarItem.title = "备忘录";
        
        
        //做题界面
        let test = TestSearchViewController()
        test.title = "Test"
        let navTest = UINavigationController(rootViewController: test)
        img = UIImage(named: "pen");
        navTest.tabBarItem.image = UIImage(data: UIImagePNGRepresentation(img!)!, scale: 1.9)
        
        
        //个人信息界面
        let me = SelfInforViewController()
        let navMe = UINavigationController(rootViewController: me)
        img = UIImage(named: "me")
        navMe.tabBarItem.image = UIImage(data: UIImagePNGRepresentation(img!)!, scale: 2.0)
        navMe.tabBarItem.title = "Me"
        
        
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
