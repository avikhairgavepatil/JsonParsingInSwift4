//
//  ApiWebServiceCall.swift
//  JsonParsingInSwift4
//
//  Created by varun daga on 17/08/18.
//  Copyright © 2018 varun daga. All rights reserved.
//

import Foundation
class ApiWebServiceCall: NSObject {
    func getDataWith(url:String,completion: @escaping (Result1<[String: AnyObject]>) -> Void) {
        
        let urlString = url;
        
        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let aa =  String(bytes: data!, encoding: String.Encoding.utf8)
 
            
            if let list = self.convertToDictionary(text: aa!) as? [String: AnyObject] {
                
                print(list);
                guard let itemsJsonArray = list["meta"] as? [String: AnyObject] else {
                    return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                }
                DispatchQueue.main.async {
                    completion(.Success(itemsJsonArray))
                }
                
            }
            
            
            
            }.resume()
    }
    func convertToDictionary(text: String) -> [String: AnyObject] {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? Any as! [String : AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return ["":"" as AnyObject]
        
    }
    
}
enum Result1<T> {
    case Success(T)
    case Error(String)
}

