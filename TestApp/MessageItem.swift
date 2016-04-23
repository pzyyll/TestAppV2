//
//  MessageItem.swift
//  Message
//
//  Created by Gatsby on 16/1/1.
//  Copyright © 2016年 Gatsby. All rights reserved.
//

import UIKit

class MessageItem {
    var id:String!
    var username:String!
    var mesg:String!
    var time:String!
    var boundingRect:CGRect!
    var imageOfMesg:String?
    
    
    func count_mesg_height(celltype:MessageItem.LCellType) -> (mesg_high:CGFloat,full_mesg_rect:CGRect){
        let lmessage = UILabel()
        lmessage.text = self.mesg
        lmessage.numberOfLines = 0
        lmessage.font = UIFont(name: "", size: 10)
        
        lmessage.lineBreakMode = NSLineBreakMode.ByWordWrapping//超过边界便换行
        let string:NSString = self.mesg
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        if celltype == LCellType.NORMALCELL{
            lmessage.lineBreakMode = NSLineBreakMode.ByTruncatingTail//表示隐藏尾部并显示省略号
          boundingRect = string.boundingRectWithSize(CGSizeMake(265, 200), options: options, attributes: [NSFontAttributeName:lmessage.font], context: nil)//限制长宽
            
            lmessage.frame = CGRectMake(100, 50, boundingRect.size.width, boundingRect.size.height)
        }else if celltype == LCellType.DETAILCELL{
          boundingRect = string.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.width-30, 406), options: options, attributes: [NSFontAttributeName:lmessage.font], context: nil)
        
            lmessage.frame = CGRectMake(20, 100, boundingRect.size.width, boundingRect.size.height)
        }
        
        return (lmessage.frame.height, lmessage.frame)
    }
    
    enum LCellType : String{
        case NORMALCELL//正常页面中的cell
        case DETAILCELL//细节页面中的cell
    }
    
}