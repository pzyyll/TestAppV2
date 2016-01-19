//
//  EditViewController.swift
//  samplenote
//
//  Created by CAIZHILI on 15/12/19.
//  Copyright © 2015年 CAIZHILI. All rights reserved.
//

import UIKit

protocol TransData {
    func sendAItem(aNote: NoteItem)
}

class EditViewController: UIViewController, UITextFieldDelegate {

    var editView: UITextView?
    var editTitle: UITextField?
    var timeLabel: UILabel?
    var createTime: NSDate?
    var saveBtn: UIBarButtonItem?
    
    var sendtoDelegate: TransData?
    
    override func loadView() {
        super.loadView()
        
        self.saveBtn = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("save"))
        self.navigationItem.rightBarButtonItem = saveBtn
        
        self.timeLabel = UILabel(frame: CGRectMake(0, self.navigationController!.navigationBar.frame.height+20, self.view.frame.width, 25))
        self.view.addSubview(self.timeLabel!)
        
        //init edit title field
        var rect = CGRectMake(0, self.timeLabel!.frame.origin.y + self.timeLabel!.frame.height, self.view.frame.width, 30)
        self.editTitle = UITextField(frame: rect)
        self.editTitle?.borderStyle = .None
        self.editTitle?.textAlignment = .Center
        self.view.addSubview(self.editTitle!)
        
        //init edit view
        rect = self.editTitle!.frame
        rect.origin.y += rect.height
        rect.size.height = self.view.frame.height - self.navigationController!.navigationBar.frame.height - self.editTitle!.frame.height - 20 - 400
        self.editView = UITextView(frame: rect)
        self.view.addSubview(self.editView!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        //depoly time label
        self.timeLabel?.textAlignment = .Center
        self.timeLabel?.backgroundColor = UIColor.clearColor()
        self.timeLabel?.textColor = UIColor.darkGrayColor()
        self.timeLabel?.font = UIFont.systemFontOfSize(10)
        self.createTime = NSDate()
        let timeform = NSDateFormatter()
        timeform.dateFormat = "yyyy年MM月dd日 HH:mm"
        self.timeLabel?.text = timeform.stringFromDate(self.createTime!)
        
        //depoly edit title
        self.editTitle?.placeholder = "Title"
        self.editTitle?.returnKeyType = .Next
        self.editTitle?.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        let aNote = NoteItem()
        if self.editTitle!.text!.isEmpty &&
        self.editView!.text!.isEmpty {
            let dateForm = NSDateFormatter()
            dateForm.dateFormat = "yyyy年MM月dd日"
            aNote.title = dateForm.stringFromDate(self.createTime!)
            
            aNote.date = self.createTime
            
        } else if self.editTitle!.text!.isEmpty {
            let dateForm = NSDateFormatter()
            dateForm.dateFormat = "yyyy年MM月dd日"
            aNote.title = dateForm.stringFromDate(self.createTime!)
            
            aNote.item = self.editView!.text
            aNote.date = self.createTime
        } else {
            aNote.title = self.editTitle!.text!
            aNote.item = self.editView!.text!
            aNote.date = self.createTime
        }
        
        self.sendtoDelegate?.sendAItem(aNote)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //self.editTitle?.resignFirstResponder()
        if (textField == self.editTitle) {
            self.editView?.becomeFirstResponder()
        }
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
