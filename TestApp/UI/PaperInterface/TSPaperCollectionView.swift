//
//  TSPaperCollectionView.swift
//  TestApp
//
//  Created by caizhili on 16/4/20.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

protocol TSPaperCollectionViewDelegate {
    func changeData() -> [String: [ExamPaper]]?
}

class TSPaperCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var papers: [String: [ExamPaper]]!
    var keys: [String]!
    
    var delegateData: TSPaperCollectionViewDelegate!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        
        papers = [String: [ExamPaper]]()
        keys = [String]()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return papers[keys[section]]!.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifer = "papercell"
        collectionView.registerNib(UINib(nibName: "PaperCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: identifer)
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifer, forIndexPath: indexPath) as! PaperCollectionViewCell
        
        let paper = self.papers[keys[indexPath.section]]![indexPath.row]
        var index = paper.ep_No
        if index.characters.last! == "m" {
            index.removeAtIndex(index.endIndex.predecessor())
        }
        cell.titleLable.text = "( \(index.characters.last!) )"
        cell.titleTextView.text = paper.ep_Name
        cell.titleTextView.font = UIFont.systemFontOfSize(10)
        cell.titleTextView.textAlignment = .Center
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return papers.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var view = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let identifier = "HeaderForPaper"
            collectionView.registerNib(UINib(nibName: "HearderForPaperCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: identifier, forIndexPath: indexPath)
            (view as! HearderForPaperCollectionReusableView).setTitleDate(keys[indexPath.section]);
        } else if kind == UICollectionElementKindSectionFooter {
            let identifier = "FootForPaper"
            collectionView.registerNib(UINib(nibName: "FootForPaperCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier)
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: identifier, forIndexPath: indexPath)
        }
        
        return view
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.frame)
        print(scrollView.contentSize)
        print(scrollView.contentOffset)
        let val = scrollView.contentSize.height - scrollView.frame.height
        print(val)
        if (scrollView.contentOffset.y > val ) {
            scrollView.contentOffset.y = val
        }
    }
    
    override func reloadData() {
        self.papers.removeAll()
        self.keys.removeAll()
        
        if self.delegateData != nil {
            if self.delegateData.changeData() != nil {
                self.papers = self.delegateData.changeData()
                for (key, _) in self.papers {
                    self.keys.append(key)
                    self.papers[key]!.sortInPlace({ (a, b) -> Bool in
                        return a.ep_No < b.ep_No
                    })
                }
                self.keys.sortInPlace({ (a, b) -> Bool in
                    return a > b
                })
            }
        }
        
        super.reloadData()
    }
}
