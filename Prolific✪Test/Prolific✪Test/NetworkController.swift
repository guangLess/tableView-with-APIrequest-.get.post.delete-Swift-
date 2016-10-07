//
//  NetworkController.swift
//  CodeTestApi
//
//  Created by Guang on 10/1/16.
//  Copyright © 2016 Guang. All rights reserved.
//
import Foundation
import Alamofire

final class NetworkControllerO {
    func load<A>(resource: Resource<A>, completion: (A?) -> ()) {
        Alamofire.request(.GET, api.get).responseJSON { response in
            switch response.result{
            case .Success:
                //print(response.result.value)
                let result = response.data.flatMap(resource.parse)
                completion(result)
            case .Failure(let error):
                print(error)
            }
        }
    }
    func postBook(book:JsonDictionary,completion: (Bool) -> ()) { //FIXME: optional add?
        Alamofire.request(.POST,api.post, parameters: book, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    completion(true)
                    break
                case .Failure:
                    print(ErrorType)
                    break
                }
        }
    }
    func deleteBook(input:NSNumber, completion: (result: Bool) -> Void) {
        let bookIDURL = String(format:"%@/%@", api.post,String(input))
        Alamofire.request(.DELETE, bookIDURL)
            .responseJSON {
                response in
                guard response.result.error == nil else {
                    print("error\(response.result.error)")
                    return
                }
                completion(result:true)
        }
    }
    func editBook (input:NSNumber, param : JsonDictionary) {
        //FIXME:// put url in the mainVC maybe... so it is less messy here?
        let bookIDURL = String(format:"%@/%@",api.post,String(input))
        Alamofire.request(.PUT, bookIDURL, parameters: param)
            .response { (request, response, data, error) in
                print(error)
        }
    }
}
/*
protocol NetworkController {
    func getBookData(completion: ([Book]) -> ())
    func postAbook(book:Book, completion: (result: Bool) -> ())
    func deleteBook(input: Int, completion: (result: String) -> ())
    func editBook (input: Int, param : [String: String])
}

struct librarySystem: NetworkController {
    private let swagApi = APIKey()
 
 func editBook (input: Int, param : [String: String]) {
 let url = swagApi.postApi
 let bookIDURL = String(format:"%@/%@",url,String(input))
 Alamofire.request(.PUT, bookIDURL, parameters: param)
 .response { (request, response, data, error) in
 print(error)
 }
 }
 }
 
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
                    print("error\(response.result.error)")
                    return
                }
                completion(result: "book deleted!")
        }
    }

 */

