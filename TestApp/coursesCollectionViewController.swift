//
//  coursesCollectionViewController.swift
//  collect
//
//  Created by raoyu on 15/12/30.
//  Copyright © 2015年 raoyu. All rights reserved.
//

import UIKit
var ctrlsel = [courseItem]()

var currentSection = 0
var currentCourseNum = 0
let reuseIdentifier = "CellIdentifier"
let headerViewIdentifier = "HeaderView"

class coursesCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    //    var scrollView = UIScrollView()
    //    var scrollViewfortest = UIScrollView()
    //    var pageControl = UIPageControl()
    var numberOfPages = 4
    var floorResultCollectionView : UICollectionView?
    //    override func viewWillAppear(animated: Bool) {
    ////        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    ////        self.collectionView?.backgroundColor = UIColor.whiteColor()
    //        self.collectionView?.reloadData()
    //    
    //    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "abc"
        
        let jsonFilePath = "/Users/caizhili/Desktop/course.json"
        //        let jsonFilePath = NSBundle.mainBundle().pathForResource("test", ofType: "json")!
        let data = NSData(contentsOfFile: jsonFilePath)
        let jsonObj = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as!    NSMutableArray
        
        //        let jsonDict = try? NSJSONSerialization.dataWithJSONObject(jsonObj!, options: NSJSONWritingOptions())
        //
        //        let str = NSString(data: jsonDict!, encoding: NSUTF8StringEncoding)
        //        print(str)
        
        for course in jsonObj! {
            //            print(course)
            var c = courseItem()
            let name = course["c_No"] as! String
            print(name)
            
            let id = course["c_Name"] as! [Dictionary<String,[String]>]
            print(id)
            
            let hobby = course["c_Introdution"] as! String
            print(hobby)
            let sss = course["c_AppendendTime"] as! String
            print(sss)
            c.c_No = name
            c.c_Name = []
            for x in id {
                
                for x2 in x{
                    var c12 = courseItemInformation()
                    c12.c_Name = x2.0
                    c12.c_Information = x2.1
                    print(c12.c_Name)
                    print(c12.c_Information)
                    c.c_Name.append(c12)
                    
                }
                
            }
            //            c.c_Name = id
            c.c_Introdution = hobby
            c.c_AppendendTime = sss
            ctrlsel.append(c)
            //            ctrlsel.append(course as! courseItem( c_o:name, c_ame:id, c_ntrodution:hobby, c_ppendendTime:sss))
        }
        
        //        scrollView.frame = CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.height/3)
        //        scrollView.delegate = self
        //        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(numberOfPages), self.view.frame.height/3)
        //        scrollView.pagingEnabled = true
        //        scrollView.bounces = false
        //        scrollView.showsHorizontalScrollIndicator = false
        //        scrollView.showsVerticalScrollIndicator = false
        //        scrollView.scrollsToTop = false
        //
        //        for i in 0..<numberOfPages {
        //            let imageView = UIImageView(image: UIImage(named: "2.jpg"))
        //            imageView.backgroundColor = UIColor.blackColor()
        //            imageView.frame = CGRectMake(self.view.frame.size.width * CGFloat(i), 10, self.view.frame.size.width/3, self.view.frame.size.height/3)
        //            scrollView.addSubview(imageView)
        //        }
        //        self.view.addSubview(scrollView)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.frame = CGRectMake(110,self.view.frame.size.height*2/3,self.view.frame.size.width,self.view.frame.size.height)
        //        flowLayout.itemSize = CGSizeMake(self.view.bounds.width/3-10, self.view.bounds.width/3-10)
        //
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSizeMake(120, 120)
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical//设置垂直显示
        
        flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1)//设置边距
        
        flowLayout.minimumLineSpacing = 10.0//每个相邻layout的上下
        
        flowLayout.minimumInteritemSpacing = 10.0//每个相邻layout的左右
        
        flowLayout.headerReferenceSize = CGSizeMake(0, 0)
        
        
        //        继续实现UICollectionView
        //        var FloorCollectionViewCell = UICollectionViewCell()
        
        floorResultCollectionView = UICollectionView(frame:self.view.frame, collectionViewLayout: flowLayout)
        
        floorResultCollectionView!.backgroundColor = UIColor.whiteColor()
        
        floorResultCollectionView!.alwaysBounceVertical = true
        
        floorResultCollectionView!.delegate = self
        
        floorResultCollectionView!.dataSource = self
        
        view.addSubview(floorResultCollectionView!)
        
//        let nib = UINib(nibName: "itemCells", bundle: NSBundle.mainBundle())
//        floorResultCollectionView?.registerNib(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        floorResultCollectionView!.registerClass(UICollectionViewCell.self,forCellWithReuseIdentifier: reuseIdentifier)
        
        floorResultCollectionView!.backgroundColor = UIColor.whiteColor()
        
        //        scrollView.addSubview(self.collectionView!)
        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ctrlsel.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ctrlsel[section].c_Name.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //        if indexPath.section == 0 {
        //
        //        }
        //        else {
        //
        //        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        //        let cell:courseCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! courseCell
        //        cell.courseName.text = "haha"
        let textLabel = UILabel(frame: CGRectMake(cell.bounds.width/3, cell.bounds.height/2, cell.bounds.size.width*2/3, cell.bounds.height/2))
        cell.addSubview(textLabel)
//        cell.contentView.addSubview(textLabel)
        var data = ctrlsel[indexPath.section]
        let cour = data.c_Name
        textLabel.text = cour[indexPath.row].c_Name
        cell.tintColor = UIColor.yellowColor()
        cell.backgroundColor = UIColor.grayColor()
        // Configure the cell
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView:Footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier, forIndexPath: indexPath) as! Footer
        headerView.sectionName = UILabel()
        headerView.sectionName.frame = CGRectMake(0, 100, (floorResultCollectionView?.frame.size.width)!, 50)
        headerView.sectionName.backgroundColor = UIColor.orangeColor()
        var data = ctrlsel[indexPath.section]
        let cour = data.c_Introdution
        headerView.sectionName.text = cour
//        headerView.sectionName.tintColor = UIColor.blackColor()
        
        return headerView
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentSection = indexPath.section
        currentCourseNum = indexPath.row
        print(indexPath.section)
        var data = ctrlsel[indexPath.section]
        let cour = data.c_Introdution
        let cours = data.c_Name[indexPath.row].c_Name
        print(cour)
        print(cours)
        var courseInformation = MyTableView2()
        self.navigationController?.pushViewController(courseInformation, animated: false)
        
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
