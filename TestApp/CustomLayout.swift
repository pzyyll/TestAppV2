//
//  CustomLayout.swift
//
//

import UIKit

/**
 * 这个类只简单定义了一个section的布局
 */
class CustomLayout : UICollectionViewLayout {
    
    //内容区域总大小，不是可见区域
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(collectionView!.bounds.size.width, CGFloat(collectionView!.numberOfItemsInSection(0) * 200 / 3 + 200))
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesArray = [UICollectionViewLayoutAttributes]()
        let cellCount = self.collectionView!.numberOfItemsInSection(0)
        for i in 0..<cellCount {
            let indexPath =  NSIndexPath(forItem:i, inSection:0)

            let attributes =  self.layoutAttributesForItemAtIndexPath(indexPath)
            
            attributesArray.append(attributes!)
        }
        
        return attributesArray
    }
    
    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        //当前单元格布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath:indexPath)
        
        //单元格外部空隙，简单起见，这些常量都在方法内部定义了，没有共享为类成员
        //let itemSpacing = 2
        //let lineSpacing = 5
        
        //单元格边长
        //let largeCellSide:CGFloat = 200
        //let smallCellSide:CGFloat = 100
        
        //内部间隙，左右5
        //let insets = UIEdgeInsetsMake(10, 10, 10, 10)//top left buttom right
        
        
        
        //当前行数，每行显示4个
        let line:Int = indexPath.item / 4
       
       // let lineOriginY = insets.top
        if (indexPath.item % 4 == 0){
         attribute.frame = CGRectMake(40*CGFloat(line+1), 40*CGFloat(line+1), 60, 60)
        }else if (indexPath.item % 4 == 1) {
            attribute.frame = CGRectMake(40*CGFloat(line+1) * 2, 40*CGFloat(line+1), 60, 60)
        }else if (indexPath.item % 4 == 2) {
            attribute.frame = CGRectMake(40*CGFloat(line+1) * 3, 40*CGFloat(line+1), 60, 60)
        }else if (indexPath.item % 4 == 3) {
            attribute.frame = CGRectMake(40*CGFloat(line+1) * 4, 40*CGFloat(line+1), 60, 60)
        }
        return attribute
    }
    
    
    /*
    func layoutAttributesForSupplementaryViewOfKind(elementKind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes!
    func layoutAttributesForDecorationViewOfKind(elementKind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes!
    */
    
    
}