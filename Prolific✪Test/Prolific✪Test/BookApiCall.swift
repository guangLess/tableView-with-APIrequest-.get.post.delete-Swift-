//
//  bookApiCall.swift
//  Prolific✪Test
//
//  Created by Guang on 5/2/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation
import Alamofire

internal final class BookApiCall {
    
    static let sharedInstance = BookApiCall()
    var bookArray = [BookInfomation]()
    private let swagApi = APIKeys()

    func getBookData(completion: ([[String: AnyObject]]) -> Void) {
        bookArray.removeAll()
        Alamofire.request(.GET, swagApi.getApi).responseJSON {
            response in
            guard response.result.error == nil
                else {
                    print ("Error. \(response.result.error?.localizedDescription) and \(response.debugDescription)")
                    return
            }
            print("Response.result.isSuccess: \(response.result.isSuccess)")
            
            if response.result.isSuccess {
                completion(response.result.value as! [[String: AnyObject]])
                for eachBook in response.result.value as! [[String : AnyObject]] {
                    let book = self.addPropertyToBook(eachBook)
                    self.bookArray.append(book)
                }
            }
        }
    }
    
    private func addPropertyToBook(book: [String : AnyObject]) -> BookInfomation {
        let book = BookInfomation(author: book["author"] as? String , categories: book["categories"] as? String, id:book["id"] as? Int, lastCheckedOut: book["lastCheckedOut"] as? String, lastCheckedOutBy: book["lastCheckedOutBy"] as? String, publisher: book["publisher"] as? String, title: book["title"] as? String, url:book["book.url"] as? String)
        return book
    }
    
    func postAbook(bookInfo:[String:AnyObject], completion: (result: Bool) -> Void) {
        let postedBookDictionary = bookInfo
        Alamofire.request(.POST, swagApi.postApi, parameters: postedBookDictionary, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    completion(result: true)
                    break
                case .Failure:
                    print(ErrorType)
                    break
                }
        }
    }
    
    func deleteBook(input: Int, completion: (result: String) -> Void) {
        print("bookId is = \(input)")
        let url = swagApi.postApi
        let bookIDURL = String(format:"%@/%@",url,String(input))
        
        Alamofire.request(.DELETE, bookIDURL)
            .responseJSON {
                response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error\(response.result.error)")
                    return
                }
                completion(result: "book deleted!")
                //print("DELETE ok")
        }
    }
    
    func editBook (input: Int, param : [String: String]) {
        let url = swagApi.postApi
        let bookIDURL = String(format:"%@/%@",url,String(input))
        Alamofire.request(.PUT, bookIDURL, parameters: param)
            .response { (request, response, data, error) in
                //print(request)
                print(response)
                print(error)
        }
    }
}