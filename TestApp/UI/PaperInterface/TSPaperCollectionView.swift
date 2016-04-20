//
//  TSPaperCollectionView.swift
//  TestApp
//
//  Created by caizhili on 16/4/20.
//  Copyright © 2016年 pzyyll. All rights reserved.
//

import UIKit

class TSPaperCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifer = "papercell"
        collectionView.registerNib(UINib(nibName: "PaperCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: identifer)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifer, forIndexPath: indexPath) as! PaperCollectionViewCell
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.cellForItemAtIndexPath(indexPath)?.selected = false
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var view = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let identifier = "HeaderForPaper"
            collectionView.registerNib(UINib(nibName: "HearderForPaperCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: identifier, forIndexPath: indexPath) as! HearderForPaperCollectionReusableView
            
        }
        
        return view
    }
    
}
