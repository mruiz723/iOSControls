//
//  Request.swift
//  ExampleAlamofirePUTDELETE
//
//  Created by Laura Mejia Arroyave on 2/23/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit
import Alamofire

public typealias CompletionHandlerGET =  (success: Bool, response: [[String : AnyObject]]) ->()
public typealias CompletionHandler =  (success: Bool, response: [String : AnyObject]) ->()

let headers = [
    "Authorization": "Basic a2lkX1cxQmtMTUhEQ3g6ZWJiZjVhODg0MGIxNDg5NWFlOTg3YzM3MjIxZDE5NGE=",
    "Content-Type": "application/x-www-form-urlencoded"
]

class Request: NSObject{
    
    let url = "https://baas.kinvey.com/appdata/kid_W1BkLMHDCx/Contacts/"
    
    func getContacts(completion:CompletionHandlerGET){
        Alamofire.request(.GET, url, parameters: nil, headers: headers)
            .responseJSON(){response in
                
                switch response.result {
                case .Success(let JSON):
                    print("Llamado de GET \(JSON)")
                    completion(success: true, response: JSON as! [[String : AnyObject]])
                case .Failure(let error):
                    completion(success: false, response: [["error":error.localizedDescription]])
                }
        }
    }
    
    func saveContact(parameters:[String: AnyObject], completion:CompletionHandler){
        Alamofire.request(.POST, url, parameters:parameters, headers:headers)
            .responseJSON(){response in
            switch response.result {
            case .Success(let JSON):
                completion(success: true, response: JSON as! [String : AnyObject])
            case .Failure(let error):
                completion(success: false, response: ["error":error.localizedDescription])
            }
        }
    }
    
    func deleteContact(contactID: String, completion:CompletionHandler){
        
        let urlWithContact : String = "\(url)\(contactID)"
        
        Alamofire.request(.DELETE, urlWithContact, parameters: nil, headers: headers)
            .responseJSON(){response in
                
                switch response.result {
                    
                case .Success(let JSON):
                    
                    print("Borrado 1 contacto")
                    completion(success: true, response: ["response":JSON])
                    
                case .Failure(let error):
                    
                    completion(success: false, response: ["error":error.localizedDescription])
                }
        }
    }
    
    func updateContact(contactID: String, parameters: [String: AnyObject], completion:CompletionHandler){
        
        let urlWithContact : String = "\(url)\(contactID)"
        
        Alamofire.request(.PUT, urlWithContact, parameters: parameters, headers: headers)
            .responseJSON(){response in
                
                switch response.result {
                case .Success(let JSON):
                    
                    print("Actualizado 1 contacto")
                    completion(success: true, response: ["response":JSON])
                    
                case .Failure(let error):
                    
                    completion(success: false, response: ["error":error.localizedDescription])
                }
                
        }
    }
}