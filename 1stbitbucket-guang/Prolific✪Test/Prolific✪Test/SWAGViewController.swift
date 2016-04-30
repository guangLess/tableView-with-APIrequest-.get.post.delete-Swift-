//
//  SWAGViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 4/29/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit
import Alamofire


class SWAGViewController: UIViewController {

    var bookArray = [bookInfomation]()
    let bookDataUrl = "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getBookData()
        // Do any additional setup after loading the view.
        //self.postABook()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBookData() {
        //let bookDataUrl = "http://prolific-interview.herokuapp.com/5720c9b20574870009d73afc/books?"
        Alamofire.request(.GET, bookDataUrl).responseJSON {
            response in
            
            guard response.result.error == nil
                else {
                    print ("Error. \(response.result.error?.localizedDescription) and \(response.debugDescription)")
                    return
            }
            print("Response.result.isSuccess: \(response.result.isSuccess)")
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)
            
            
            
            
            if response.result.isSuccess {
                print("Response JSON: \(response.result.value)")
                
                
                // complition block
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
                print("bookArray.count = \(self.bookArray.count) and the last book is = \(self.bookArray.last)")
            }
        }
    }
    
    // can you populated the data model by the api call, instand like book : key .. value, not manuelly typed
    func addPropertyToBook(book: [String : AnyObject]) -> bookInfomation {
        let book = bookInfomation(author: book["author"] as? String , categories: book["categories"] as? String, id:book["id"] as? Int, lastCheckedOut: book["lastCheckedOut"] as? String, lastCheckedOutBy: book["lastCheckedOutBy"] as? String, publisher: book["publisher"] as? String, title: book["title"] as? String, url:book["book.url"] as? String)
        return book
    }
    
    func postABook() {
        //let bookParameters = bookInfomation(author: "Guang", categories: "art", id: nil, lastCheckedOut: nil, lastCheckedOutBy: nil, publisher: "life", title: "Coffee and Tea", url: "www.hello.work")
        
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
        
        let parameterDictionary = bookInfomation(author: "Guang", categories: "art", id: nil, lastCheckedOut: nil, lastCheckedOutBy: nil, publisher: "life", title: "Coffee and Tea", url: "www.hello.work")
         print("parameterDictionary.dictionary is \(parameterDictionary.dictionary)")
        // I do not know how to unwrap this!
        
        Alamofire.request(.DELETE, bookDataUrl, parameters:parameter, encoding: .JSON)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .Success :
                    self.getBookData()
                    // Handle success case...
                    break
                case .Failure :
                    // Handle failure case...
                    break
                }
        }
        
    }
}
