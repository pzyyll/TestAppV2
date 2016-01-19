//
//  InstallViewController.swift
//  LoginUI
//
//  Created by CAIZHILI on 15/12/20.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class InstallViewController: UIViewController, UIScrollViewDelegate {

    var pageControl: UIPageControl?
    var scrollView: UIScrollView?
    
    var backImgs = ["1", "2", "3", "4"]
    let btn = UIButton()
    
    override func loadView() {
        super.loadView()
        
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.pageControl = UIPageControl(frame: self.view.frame)
        
        self.scrollView?.contentSize = CGSizeMake(
            CGFloat(CGRectGetWidth(self.view.bounds)) * CGFloat(self.backImgs.count),
            CGRectGetHeight(self.view.bounds)
        )
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.scrollsToTop = false
        scrollView?.delegate = self
        scrollView?.userInteractionEnabled = true
        self.view.userInteractionEnabled = true
        scrollView?.pagingEnabled = true
        let size = scrollView?.bounds.size
        print(size)
        for seq in 0..<backImgs.count {
            let page = UIView()
            //page.backgroundColor = UIColor(patternImage: UIImage(named: backImgs[seq])!)
            page.frame = CGRect(x: CGFloat(seq) * size!.width, y: 0, width: size!.width, height: size!.height)
            print(page.frame)
            let imgView = UIImageView()
            imgView.image = UIImage(named: backImgs[seq])
            imgView.frame = page.bounds
            page.addSubview(imgView)
            if (seq == 3) {
                print(seq)
                
                btn.backgroundColor = UIColor.darkGrayColor()
                btn.alpha = 0.6
                btn.setTitle("现在开始", forState: .Normal)
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                btn.setTitleColor(UIColor.redColor(), forState: .Highlighted)
                btn.addTarget(self, action: Selector("nowBeging"), forControlEvents: .TouchUpInside)
                btn.frame = CGRectMake(0, 0, 200, 30)
                print(page.center)
                btn.center = self.view.center
                btn.enabled = true
                btn.userInteractionEnabled = true
                page.addSubview(btn)
                page.userInteractionEnabled = true
            }
            
            scrollView?.addSubview(page)
        }
        
        
        pageControl?.backgroundColor = UIColor.clearColor()
        pageControl?.numberOfPages = self.backImgs.count
        pageControl?.currentPage = 0
        pageControl?.addTarget(self, action: "pageChange:", forControlEvents: .ValueChanged)
        self.pageControl?.userInteractionEnabled = true
        pageControl?.frame.size.height = 30
        pageControl?.frame.origin.y = self.view.frame.height - 50
        
        self.view.addSubview(self.scrollView!)
        self.view.addSubview(self.pageControl!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(self.scrollView!.contentOffset.x / self.scrollView!.frame.width)
        self.pageControl?.currentPage = page
        
        print(page)
    }
    
    func pageChange(sender: UIPageControl) {
        var frame = scrollView?.frame
        frame!.origin.x = frame!.width * CGFloat(sender.currentPage)
        frame?.origin.y = 0
        print(frame!)
        scrollView?.scrollRectToVisible(frame!, animated: true)
    }
    
    func nowBeging() {
        let login = LoginViewController()
        self.presentViewController(login, animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
