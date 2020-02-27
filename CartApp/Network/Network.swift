//
//  Network.swift
//  CartApp
//
//  Created by User on 2/27/20.
//  Copyright © 2020 jonathanking. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Network {
    
    static func fetch<T: Decodable>(_ url: String, printResponse: Bool? = false, completion: @escaping (Swift.Result<T, Error>) -> Void) {
      
        AF.request(url).response { (response) in
           
            do {
                if let data = response.data {
                    if printResponse == true {
                        if let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                                print(JSONObject)
                        }
                    }
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    //print(String(data: data, encoding: .utf8))
                    let object = try decoder.decode(T.self, from: data)
                    completion(.success(object))
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
    
    
}


