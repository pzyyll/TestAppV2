//
//  OnePartOfChoice.swift
//  TestApp
//
//  Created by CAIZHILI on 15/12/29.
//  Copyright © 2015年 pzyyll. All rights reserved.
//

import Foundation

class OnePartOfChoice {
    var intro = ""
    var ansScore = ""
    var topics = [ATopic]()
    
    init() {}
    init(intro: String, ansScore: String, topics: [ATopic]) {
        self.intro = intro;
        self.ansScore = ansScore
        self.topics = topics
    }
}