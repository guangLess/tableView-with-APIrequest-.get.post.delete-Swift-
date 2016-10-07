//
//  NetworkController.swift
//  CodeTestApi
//
//  Created by Guang on 10/1/16.
//  Copyright © 2016 Guang. All rights reserved.
//
import Foundation
import Alamofire

final class NetworkController{
    func load<A>(resource: Resource<A>, completion: (A?) -> ()) {
        Alamofire.request(.GET, api.get).responseJSON { response in
            switch response.result{
            case .Success:
                let result = response.data.flatMap(resource.parse)
                completion(result)
            case .Failure(let error):
                print(error)
            }
        }
    }
    func postBook(book:JsonDictionary,completion: (Bool) -> ()) {
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
        let bookIDURL = String(format:"%@/%@",api.post,String(input))
        Alamofire.request(.PUT, bookIDURL, parameters: param)
            .response { (request, response, data, error) in
                print(error)
        }
    }
}
