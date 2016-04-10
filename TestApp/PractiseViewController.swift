//
//  PractiseViewController.swift
//  TestApp
//
//  Created by Gatsby on 16/4/5.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit
import WebKit

class PractiseViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let numOfPages = 3
    
    var scrollView:UIScrollView!
    var pageControl:UIPageControl?
    var timer:NSTimer!
    var collectionView:UICollectionView?
    var smalltblView:UITableView?
    var smallView:UIView!
    var arr : [String] = ["CET-4", "CET-6", "TEM-4", "TEM-6", "GRE", "more"] //"TOFEL", "N2"]
    
    var num:CGFloat = 1.0
    var flag = true
    
    var webAct: WKWebView!
    var ddlleeggaattee:SmallTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(10),target:self,selector:#selector(PractiseViewController.countTime),userInfo:nil,repeats:true)
        
        
        readyForMainPageView()
        readyForWKWebView()
        readyForCollectionView()
    }
    
        
    func readyForMainPageView(){
        
        let frame = self.view.bounds
        self.scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 250)//self.view.bounds
        
        scrollView.contentSize=CGSizeMake(frame.size.width*CGFloat(numOfPages),0)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        scrollView.bounces = false
        for i in 0..<numOfPages{
            let myViewController = AdViewController(number: (i+1))
            //设置每一页内容的位置
            myViewController.view.frame = CGRectMake(frame.size.width*CGFloat(i),CGFloat(0),frame.size.width,frame.size.height)
            scrollView.addSubview(myViewController.view)
        }
        
        scrollView.contentOffset = CGPointZero
        
        self.pageControl=UIPageControl(frame: CGRectMake(self.view.frame.size.width/2-50, 210, 100, 25))
        self.pageControl!.numberOfPages=3
        self.pageControl!.currentPage=0
        self.pageControl!.addTarget(self, action: #selector(PractiseViewController.pageChanged(_:pageNum:)),forControlEvents: UIControlEvents.ValueChanged)
        //self.pageControl!.backgroundColor = UIColor.grayColor()
        
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl!)
    }
    
    func countTime(){
        pageChanged(pageControl, pageNum: num)
        
        if flag == true{
            num = num + 1
            if(num == 2.0){flag = false}
        }else{
            num = num - 1
            if(num == 0.0){flag = true}
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        _ = CGFloat(numOfPages-1) * self.view.bounds.size.width
        let offset=scrollView.contentOffset
        self.pageControl!.currentPage=Int(offset.x/self.view.frame.size.width)
    }
    
    func pageChanged(sender:UIPageControl?, pageNum:CGFloat){
        //print(pageNum)
        if sender != nil{
            var frame = scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(pageNum)
            frame.origin.y = 0
        
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    func readyForWKWebView(){
        webAct = WKWebView(frame: CGRectMake(0, 250, UIScreen.mainScreen().bounds.width, 190))
        webAct.scrollView.scrollEnabled = false
        self.view.addSubview(webAct)
        
        let req = NSMutableURLRequest(URL: NSURL(string: "http://www.html5tricks.com/demo/html5-css3-car-animation/index.html")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        webAct.loadRequest(req)
    }
    
    func readyForCollectionView(){
        
        //self.view.backgroundColor = UIColor.blueColor()
        
        let flowLayout = UICollectionViewFlowLayout()
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 450, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-450),collectionViewLayout: flowLayout)
        //register a cell
        self.collectionView!.registerClass(CustomCLcell.self, forCellWithReuseIdentifier: "ocell")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.bounces = false
        flowLayout.itemSize = CGSizeMake(100, 100)//每个cell的大小
        self.view.addSubview(self.collectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCLcell
        
        cell.toggleSelected()
        
        if indexPath.row == arr.count-1{
            let courseCtr = SmallTableViewDelegate()
            self.addChildViewController(courseCtr)
            self.view.addSubview(courseCtr.view);
            self.didMoveToParentViewController(self)
//            if(self.smallView.hidden == true){
//                let animation = CATransition()
//                animation.duration = 0.3
//                animation.fillMode = kCAFillModeForwards
//                animation.type = kCATransitionPush
//                animation.subtype = kCATransitionFromLeft
//            
//                self.smallView.hidden = false
//                self.smallView.layer.addAnimation(animation, forKey: nil)
//            } else {
//                self.smallView.hidden = true
//                
//                let animation2 = CATransition()
//                animation2.duration = 0.3
//                //animation.fillMode = kCAFillModeForwards
//                animation2.type = kCATransitionReveal
//                animation2.subtype = kCATransitionFromRight
//
//                self.smallView.layer.addAnimation(animation2, forKey: nil)
//            }
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCLcell
        cell.untoggleSelected()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return arr.count//return how many cell you have
    }
    
    //获取单元格
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ocell", forIndexPath: indexPath) as! CustomCLcell
        
        
        cell.nameLabel?.text = arr[indexPath.item]
        if indexPath.row == arr.count-1{
            cell.imgView?.image = UIImage(named: "icon_subject_add")
        }else{
            cell.imgView?.image = UIImage(named: "icon_subject_yingyu")
        }
        
        return cell
    }
    
    //調整並返回collectionView的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 20, 10, 10)
    }
    

}
