//
//  bookApiCall.swift
//  Prolific✪Test
//
//  Created by Guang on 5/2/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation
import Alamofire


class BookApiCall {
    
    static let sharedInstance = BookApiCall()
    
    var bookArray = [BookInfomation]()
    let bookDataUrl = "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?"

    func getBookData(completion: ([[String: AnyObject]]) -> Void) {
        //let bookDataUrl = "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?"
        Alamofire.request(.GET, bookDataUrl).responseJSON {
            response in
            
            guard response.result.error == nil
                else {
                    print ("Error. \(response.result.error?.localizedDescription) and \(response.debugDescription)")
                    return
            }
            print("Response.result.isSuccess: \(response.result.isSuccess)")
            /*
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)
            */
            if response.result.isSuccess {
                //print("Response JSON: \(response.result.value)")
                completion(response.result.value as! [[String: AnyObject]])
                
                //var i = 0
                var bArray = [[String:AnyObject]]()
                bArray = response.result.value as![[String:AnyObject]]
                print("The bArray = \(bArray.last)")
                
                for eachBook in response.result.value as! [[String : AnyObject]] {
                    //i+=1
                    let book = self.addPropertyToBook(eachBook)
                    //self.bookArray.append(book)
                    /*
                     var book = bookInfomation()
                     book.author = eachBook["author"] as? String
                     book.categories = eachBook["categories"] as? String
                     book.id =  eachBook["id"] as? Int
                     book.lastCheckedOut = eachBook["lastCheckedOut"] as? String
                     book.lastCheckedOutBy = eachBook["lastCheckedOutBy"] as? String
                     book.publisher = eachBook["publisher"] as? String
                     book.title = eachBook["title"] as? String
                     book.url = eachBook["url"] as? String
                     */
                    self.bookArray.append(book)
                }
            }
        }
    }
    
    // can you populated the data model by the api call, instand like book : key .. value, not manuelly typed
    private func addPropertyToBook(book: [String : AnyObject]) -> BookInfomation {
        let book = BookInfomation(author: book["author"] as? String , categories: book["categories"] as? String, id:book["id"] as? Int, lastCheckedOut: book["lastCheckedOut"] as? String, lastCheckedOutBy: book["lastCheckedOutBy"] as? String, publisher: book["publisher"] as? String, title: book["title"] as? String, url:book["book.url"] as? String)
        return book
    }
    
    func postABook(completion:([String: AnyObject]) -> Void) {
  
        /*
         // let parameter = bookParameters as [String : AnyObject]
         let parameter = [  "author": "GuangZZ",
         "categories": "iOS",
         "id": 13,
         "lastCheckedOut": "",
         "lastCheckedOutBy": "",
         "publisher": "School Of Life",
         "title": "Coffee is a Tea's friend",
         "url": "nanananan.com"
         ]
         */
        let bookParameters = BookInfomation(author: "Zhu", categories: "job hunting", id: nil, lastCheckedOut: nil, lastCheckedOutBy: "Guang", publisher: "Market", title: "Job hunt is painful", url: "job-hunt")
        let postedBookDictionary = bookParameters.dictionary

        Alamofire.request(.POST, bookDataUrl, parameters: postedBookDictionary ,encoding: .JSON)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .Success :
                    completion(response.result.value as! [String: AnyObject])
                    break
                case .Failure :
                    // Handle failure case...
                    
                    break
                }
        }
    }
}