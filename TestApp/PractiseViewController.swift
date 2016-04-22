//
//  PractiseViewController.swift
//  TestApp
//
//  Created by Gatsby on 16/4/5.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit
import WebKit
import CoreData


class PractiseViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectTheCourseControllerDataSource {
    
    
    let numOfPages = 3
    
    var scrollView:UIScrollView!
    var pageControl:UIPageControl?
    var timer:NSTimer!
    var collectionView:UICollectionView?
    var smalltblView:UITableView?
    var smallView:UIView!
    
    var arr = [CourseEntity]()
    var evarr : [Course]!
    var num:CGFloat = 1.0
    var flag = true
    
    var webAct: WKWebView!
    
    var appDelegate:AppDelegate!
    
    var eventArr:NSMutableArray!
    let boolKey = "TestApp_Course"
    let entityName = "CourseEntity"
    let cellIdentifier = "ocell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(10),target:self,selector:#selector(PractiseViewController.countTime),userInfo:nil,repeats:true)
        
        self.appDelegate = (UIApplication.sharedApplication().delegate) as!  AppDelegate
        
        saveArr_coredata()
        
        readyForMainPageView()
        readyForWKWebView()
        readyForCollectionView()
    }
    
    //////////////
    
    func saveArr_coredata() {
        
        //print("inside")
        if !NSUserDefaults.standardUserDefaults().boolForKey(boolKey) {
                        let firstCourse = Course()
                        firstCourse.c_No = "c00001"
                        firstCourse.c_Name = "En_LV4";
                        firstCourse.c_Intro = "大学英语四级";
                        let secCourse = Course()
                        secCourse.c_No = "c00002"
                        secCourse.c_Name = "En_LV6";
                        secCourse.c_Intro = "大学英语六级"
            
                        self.evarr = [firstCourse, secCourse];
            //self.arr = Course.getAllCourse(2);
            
            for item in evarr {
                let myevent = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: appDelegate.managedObjectContext) as! CourseEntity
                
                myevent.c_No = item.c_No
                myevent.c_Name = item.c_Name
                
                arr.append(myevent)
                
                do {
                    try  self.appDelegate.managedObjectContext.save()
                    print("do save")
                }catch let err as NSError{
                    print("save error \(err), \(err.userInfo)")
                }
                
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: boolKey)
        }
        else{
            let req = NSFetchRequest()
            let entity:NSEntityDescription? = NSEntityDescription.entityForName(entityName, inManagedObjectContext: self.appDelegate.managedObjectContext)
            
            req.entity = entity
            do{
                let ab = try  self.appDelegate.managedObjectContext.executeFetchRequest(req) as! [CourseEntity]
                arr = ab
                //print("find req arr.count \(arr.count)")
            }catch let err as NSError{
                print("req err \(err.userInfo)")
            }
        }
    }
    
    /////////////
    func readyForMainPageView(){
        
        let frame = self.view.bounds
        self.scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 240)//self.view.bounds
        
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
        
        self.pageControl=UIPageControl(frame: CGRectMake(self.view.frame.size.width/2-50, scrollView.frame.height*4/5, 100, 25))
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
        if sender != nil{
            var frame = scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(pageNum)
            frame.origin.y = 0
            
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    func readyForWKWebView(){
        webAct = WKWebView(frame: CGRectMake(0, scrollView.frame.height, UIScreen.mainScreen().bounds.width, 130))
        webAct.scrollView.scrollEnabled = false
        self.view.addSubview(webAct)
        
        let req = NSMutableURLRequest(URL: NSURL(string: "http://www.html5tricks.com/demo/html5-css3-car-animation/index.html")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        webAct.loadRequest(req)
    }
    
    func readyForCollectionView(){
        
        //self.view.backgroundColor = UIColor.blueColor()
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 40, bottom: 60, right: 60)
        let startHigh = scrollView.frame.height + webAct.frame.height
        self.collectionView = UICollectionView(frame: CGRectMake(0, startHigh, UIScreen.mainScreen().bounds.width, self.view.bounds.height - startHigh),collectionViewLayout: flowLayout)
        //register a cell
        self.collectionView!.registerClass(CustomCLcell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.bounces = false
        flowLayout.itemSize = CGSizeMake(60, 60)//每个cell的大小
        self.view.addSubview(self.collectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCLcell
        
        cell.toggleSelected()
        
        if indexPath.row == arr.count {
            let courseCtr = SelectTheCourseController()
            courseCtr.dataSourceDelegate = self
            
            self.addChildViewController(courseCtr)
            self.view.addSubview(courseCtr.view);
            self.didMoveToParentViewController(self)
        }else{
            let trans = MainTableViewController()
            self.navigationController?.pushViewController(trans, animated: true)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCLcell
        cell.untoggleSelected()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        //return arr.count + 1//return how many cell you have
        return arr.count + 1
    }
    
    //获取单元格
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomCLcell
        
        
        if indexPath.row == arr.count {
            cell.imgView?.image = UIImage(named: "icon_subject_add")
            cell.nameLabel?.font = UIFont(name: "Chalkboard SE", size: 18)
            cell.nameLabel?.text = "more"
        }else{
            cell.nameLabel?.font = UIFont(name: "Chalkboard SE", size: 18)
            cell.nameLabel?.text = arr[indexPath.item].c_Name
            cell.imgView?.image = UIImage(named: "icon_subject_yingyu")
        }
        
        return cell
    }
    
    //調整並返回collectionView的间距
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
//        return UIEdgeInsetsMake(10, 20, 10, 10)
//    }
    
    
    func changeData() -> [CourseEntity]? {
        return arr
    }
    
}
