//
//  Book.swift
//  CodeTestApi
//
//  Created by Guang on 10/1/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation

struct Book {
    var author: AnyObject?
    var categories: AnyObject?
    var id: AnyObject? //NSNumber
    var lastCheckedOut: AnyObject?//NSMu
    var lastCheckedOutBy: AnyObject?//NSMU
    var publisher: AnyObject?
    var title: AnyObject?
    var url: AnyObject?//NSMu
    var dictionary: [String : String] {
        get {
            return [
                "author": castToString(author),
                "title":castToString(title),
                "categories": castToString(categories),
                "id":castToString(id),
                "lastCheckedOut":castToString(lastCheckedOut),
                "lastCheckedOutBy":castToString(lastCheckedOutBy),
                "publisher": castToString(publisher),
                "url":castToString(url),
            ]
        }
    }
    private func castToString(content: AnyObject?) -> String {
        if let returnString = content {
            return returnString as! String
        }
        return "noData"
    }
}