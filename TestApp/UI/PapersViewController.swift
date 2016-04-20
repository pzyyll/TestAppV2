//
//  PapersViewController.swift
//  TestApp
//
//  Created by CAIZHILI on 16/3/31.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class PapersViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        // Do any additional setup after loading the view.
    }
    
    func configView() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 120
        layout.itemSize.width = 90
        layout.headerReferenceSize = CGSizeMake(0, 32)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 30, bottom: 20, right: 30)
        let collectionView = TSPaperCollectionView(frame: CGRectMake(0, 110, self.view.frame.width, self.view.frame.height - 100 - 44), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
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
