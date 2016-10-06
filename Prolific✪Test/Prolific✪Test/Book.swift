//
//  Book.swift
//  CodeTestApi
//
//  Created by Guang on 10/1/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation
//import Alamofire

typealias JsonDictionary = [String:AnyObject]
let api = API()

struct Book {
    let author: String
    let title: String
    let categories: String
    let id: NSNumber
    let lastCheckedOut: AnyObject
    let lastCheckedOutBy: AnyObject
    let publisher: String
    let url: AnyObject
    var dictionary: JsonDictionary {
        get {
            return [
                "author": author,
                "title":title,
                "categories": categories,
                "id":id,
                "lastCheckedOut":lastCheckedOut,
                "lastCheckedOutBy":lastCheckedOutBy,
                "publisher": publisher,
                "url":url
            ]
        }
    }
    init?(dictionary:JsonDictionary) {
        guard let author = dictionary["author"] as? String,
            let title = dictionary["title"] as? String,
            let categories = dictionary["categories"] as? String,
            let id = dictionary["id"] as? NSNumber,
            let lastCheckedOut = dictionary["lastCheckedOut"],
            let lastCheckedOutBy = dictionary["lastCheckedOutBy"],
            let publisher = dictionary["publisher"] as? String,
            let url = dictionary["url"] else { return nil }
        
        self.author = author
        self.title = title
        self.categories = categories
        self.id = id
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
        self.url = url
        
    }
}
extension Book {
    static let all = Resource<[Book]>(parseJSON: { json in
        guard let dictionaries = json as? [JsonDictionary] else { return nil }
        return dictionaries.flatMap(Book.init)
    })
}
struct Resource<A> {
    //let url: NSURL
    let parse: NSData -> A?
    init(parseJSON: AnyObject -> A?){
        //self.url = url
        self.parse = { data in
            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(json)
            return json.flatMap(parseJSON)
        }
    }
}