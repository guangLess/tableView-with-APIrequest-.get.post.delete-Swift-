//
//  bookInfomation.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation
/*
 "author": "Zigurd Mednieks, Laird Dornin, G. Blake Meike, Masumi Nakamura",
 "categories": "android",
 "id": 2,
 "lastCheckedOut": null,
 "lastCheckedOutBy": null,
 "publisher": "O'Reilly Media",
 "title": "Programming Android",
 "url": "/books/2/"
 */


/*
 struct MyStruct{
 var name: String
 var dictionary: [String: AnyObject]{
 get {
 return ["name": name]
 }
 }
 }

 */

struct bookInfomation {
    
    var author : String?
    var categories : String?
    var id : Int?
    var lastCheckedOut : String?
    var lastCheckedOutBy : String?
    var publisher : String?
    var title : String?
    var url : String?
    
    var dictionary: [String : AnyObject?]{
        get {
            return [
            "author" : author,
            "categories": categories,
            "id":id,
            "lastCheckedOut":lastCheckedOut,
            "lastCheckedOutBy":lastCheckedOutBy,
            "publisher":publisher,
            "title":title,
            "url":url
            ]
        }
    }
    
    /*
    
    static func jsonArray(array : [bookInfomation]) -> String
    {
        return "[" + array.map {$0.jsonRepresentation}.joinWithSeparator(",") + "]"
    }
    
    var jsonRepresentation : String {
        //{"author": "Jason Morris", "categories": "interface, ui, android", "id": 1, "lastCheckedOut": null, "lastCheckedOutBy": null, "title": "User Interface Development: Beginner's Guide", "url": "/books/1/"}
        //{\"sentence\":\"\(sentence)\",\"lang\":\"\(lang)\"}
        return "{\"author\":\"\(", "categories": "interface, ui, android", "id": 1, "lastCheckedOut": null, "lastCheckedOutBy": null, "title": "User Interface Development: Beginner's Guide", "url": "/books/1/"}"

    }


let sentences = [Sentence(sentence: "Hello world", lang: "en"), Sentence(sentence: "Hallo Welt", lang: "de")]
let jsonArray = Sentence.jsonArray(sentences)
print(jsonArray) // [{"sentence":"Hello world","lang":"en"},{"sentence":"Hallo Welt","lang":"de"}]
  
 */
}
