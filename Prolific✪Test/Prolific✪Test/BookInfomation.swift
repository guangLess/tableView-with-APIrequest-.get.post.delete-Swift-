//
//  bookInfomation.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation

struct BookInfomation {
    
    var author : String?
    var categories : String?
    var id : Int?
    var lastCheckedOut : String?
    var lastCheckedOutBy : String?
    var publisher : String?
    var title : String?
    var url : String?
    
    var dictionary: [String : AnyObject]{
        get {
            return [
            "author" : author ?? "This book has no author.😜",
            "title":title ?? "Na title😜",
            "categories": categories ?? "No Tag",
            "id":id ?? "",
            "lastCheckedOut":lastCheckedOut ?? "No Person Checked it out yet 😜 be the first one!",
            "lastCheckedOutBy":lastCheckedOutBy ?? "😜No date",
            "publisher":publisher ?? "😜",
            "url":url ?? "😜"
            ]
        }
    }
}
