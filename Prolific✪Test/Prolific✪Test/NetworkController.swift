//
//  NetworkController.swift
//  CodeTestApi
//
//  Created by Guang on 10/1/16.
//  Copyright © 2016 Guang. All rights reserved.
//
import Foundation
import Alamofire

protocol NetworkController {
    func getBookData(completion: ([Book]) -> ())
    func deleteBook(input: Int, completion: (result: String) -> ())
}

struct librarySystem: NetworkController {
    private let swagApi = APIKey()
    // static let sharedInstance = librarySystem()
      func getBookData(completion: ([Book]) -> Void) {
        Alamofire.request(.GET, swagApi.getApi).responseJSON { response in
            switch response.result{
            case .Success:
                let resultData = response.result.value as! NSMutableArray
                var books = [Book]()
                var i = resultData.count
                for eachBook in resultData{
                    //print(eachBook)
                    let eachModel = self.makeBook(eachBook as! [String : AnyObject])
                    books.append(eachModel)
                    i -= 1
                    if i == 0 {
                        completion(books)
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    private func makeBook(eachBook: [String : AnyObject]) -> Book{
        let author = eachBook["author"]
        let id = eachBook["id"]
        let lastCheckedOut = eachBook["lastCheckedOut"]
        let lastCheckedOutBy = eachBook["lastCheckedOutBy"]
        let publisher = eachBook["publisher"]
        let title = eachBook["title"]
        let url = eachBook["url"]
        let categories = eachBook["categories"]
        return Book(author: author, categories:categories, id: id, lastCheckedOut: lastCheckedOut, lastCheckedOutBy: lastCheckedOutBy, publisher: publisher, title: title, url: url)
        }

    func postAbook(book:Book, completion: (result: Bool) -> Void) {
        //let postedBookDictionary = bookInfo
        Alamofire.request(.POST, swagApi.postApi, parameters: book.dictionary, encoding: .JSON)
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

