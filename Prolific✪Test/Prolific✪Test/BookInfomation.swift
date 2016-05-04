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
    
    //var nameOfPerson: NSString
    // NSString *newName = @"Jim";
    var dictionary: [String : AnyObject]{
        get {
            return [
            "author" : author ?? "",
            "categories": categories ?? "",
            "id":id ?? "",
            "lastCheckedOut":lastCheckedOut ?? "",
            "lastCheckedOutBy":lastCheckedOutBy ?? "",
            "publisher":publisher ?? "",
            "title":title ?? "",
            "url":url ?? ""
            ]
        }
    }
}
