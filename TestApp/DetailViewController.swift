//
//  DetailViewController.swift
//  samplenote
//
//  Created by CAIZHILI on 15/12/20.
//  Copyright © 2015年 CAIZHILI. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: EditViewController {
    
    var detailNoteItem: NoteItem?
    
    override func loadView() {
        super.loadView()
        self.navigationItem.rightBarButtonItem = nil
        self.editTitle?.enabled = false
        self.editView?.editable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel?.text = detailNoteItem?.getStringDate()
        self.editTitle?.text = detailNoteItem?.title
        self.editView?.text = detailNoteItem?.item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}