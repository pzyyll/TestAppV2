//
//  CustemView.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/27.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    //文本视图，用来显示文章内容
    var textView: UITextView!
    //选择视图，用来显示问题及选择项
    var selectView: UIScrollView!
    //拖动按钮
    var labelBtn: UIImageView!
    var aler: UILabel!
    //设置select view 下table view，即该题下问题详情
    //var tableViews: [MyTableView]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rebuil()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rebuil() {
        self.textView = UITextView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height / 2))
        //self.textView.text = "Content"
        self.textView.editable = false
        self.textView.userInteractionEnabled = true
        
        self.labelBtn = UIImageView(frame: CGRectMake(0, 0, 50, 26))
        self.labelBtn.center.x = self.frame.width / 2
        self.labelBtn.center.y = self.frame.height / 2
        self.labelBtn.backgroundColor = UIColor.darkGrayColor()
        self.labelBtn.alpha = 0.7
        self.labelBtn.layer.cornerRadius = 6.0
        self.labelBtn.layer.masksToBounds = true
        let pan = UIPanGestureRecognizer(target: self, action: "panDid:")
        pan.maximumNumberOfTouches = 1
        self.labelBtn.userInteractionEnabled = true
        self.labelBtn.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: "tapAler:")
        tap.numberOfTapsRequired = 1
        self.labelBtn.addGestureRecognizer(tap)
    
        self.selectView = UIScrollView(frame: CGRectMake(0, self.textView.frame.height, self.frame.width, self.frame.height / 2))
        self.selectView.backgroundColor = UIColor.darkGrayColor()
        self.selectView.showsHorizontalScrollIndicator = false
        self.selectView.showsVerticalScrollIndicator = false
        self.selectView.pagingEnabled = true
        
        self.addSubview(textView)
        self.addSubview(labelBtn)
        self.addSubview(selectView)
    }
    
    func panDid(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.locationInView(self)
        //print(point)
        if (point.y > 30) {
            //修改拖动标签的位置
            self.labelBtn.center.y = point.y
            
            //更新选择视图的原点，高度
            self.selectView.frame.size.height = self.frame.height - self.labelBtn.center.y
            self.selectView.frame.origin.y = self.labelBtn.center.y
            self.selectView.contentSize.height = CGRectGetHeight(self.selectView.frame)
            //更新选择视图的子视图的高度
            for tableview in self.selectView.subviews {
                tableview.frame.size.height = self.selectView.frame.height
            }
            
            //更新文本视图的高度
            self.textView.frame.size.height = self.frame.height - self.selectView.frame.height
        }
    }
    
    func tapAler(sender: UITapGestureRecognizer) {
        self.aler = UILabel(frame: CGRectMake(0, 0, 64, 20))
        self.aler.center = CGPointMake(self.frame.width / 2, 50)
        self.aler.backgroundColor = UIColor(red: 26 / 255, green: 26 / 255, blue: 26 / 255, alpha: 0.8)
        self.aler.text = "可以拖动哦~~"
        self.aler.textAlignment = .Center
        self.aler.font = UIFont.systemFontOfSize(9)
        self.aler.textColor = UIColor.whiteColor()
        self.aler.layer.cornerRadius = 2
        self.aler.layer.masksToBounds = true
        
        print(self.aler.center)
        
        self.addSubview(self.aler)
        
        UIView.animateWithDuration(4, animations: { () -> Void in
            self.aler.alpha = 0.0
            }) { (finished) -> Void in
                self.aler.removeFromSuperview()
        }
    }
    
    func setSelectTableViews(tableViews: [UIView]) {
        //self.tableViews = tableViews as? [MyTableView]
        var cnt = 0
        self.selectView.contentSize = CGSize(width: self.frame.width * CGFloat(tableViews.count), height: self.selectView.frame.height)
//        let maxSizeCnt = self.selectView.contentSize.width / self.selectView.frame.width
        for tableView in tableViews {
//            if (cnt < Int(maxSizeCnt)) {
                print(cnt)
                tableView.frame = CGRectMake(CGFloat(cnt) * self.frame.width, 0, CGRectGetWidth(self.selectView.frame), CGRectGetHeight(self.selectView.frame))
                self.selectView.addSubview(tableView)
                ++cnt
//            } else {
//                break
 //           }
        }
    }
    
    func setTextViewText(text: String) {
        self.textView.text = text
    }
    
    func setTitleStyle() {
        self.selectView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        for view in self.selectView.subviews {
            view.frame = self.selectView.frame
        }
    }
}
