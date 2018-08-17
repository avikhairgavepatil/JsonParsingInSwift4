//
//  ApiWebServiceCallWithHtmlContent.swift
//  JsonParsingInSwift4
//
//  Created by varun daga on 17/08/18.
//  Copyright © 2018 varun daga. All rights reserved.
//

import Foundation
class ApiWebServiceCallWithHtmlContent: NSObject {
    
    
    
    func getDataWith(url:String,completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        let urlString = url;
        
        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            
            if(data == nil)
            {
                
                
                
            }
            else{
                
                let aa =  String(bytes: data!, encoding: String.Encoding.utf8)
                
                let str = aa?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                //print(str ?? <#default value#>)
                
                if let list = self.convertToDictionary(text: str!) as? [String: AnyObject] {
                    
                    print(list);
                    guard let itemsJsonArray = list["data"] as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                    
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
enum Result<T> {
    case Success(T)
    case Error(String)
}
