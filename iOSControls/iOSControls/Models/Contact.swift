//
//  Contacts.swift
//  ExampleAlamofirePUTDELETE
//
//  Created by Laura Mejia Arroyave on 2/24/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit


class Contact {
    
    typealias CompletionHandler = (success: Bool, response: Contact) ->()
    typealias CompletionHandlerContacts = (success: Bool, response: [Contact]) ->()
    
    //MARK: - Properties
    var id: String?
    var name: String?
    var lastName: String?
    var phone: String?
    var email: String?
    
    //MARK: - Init
    init(id: String, name:String, lastName:String, phone:String, email:String){
        self.id = id
        self.name = name
        self.lastName = lastName
        self.phone = phone
        self.email = email
    }
    
    convenience init(){
        
        self.init(id:"", name:"", lastName:"", phone:"", email:"")
        
    }
    
    class func getContacts(completion: CompletionHandlerContacts){
        
        Request.sharedRequest.getContacts { (success, response) -> () in
            var contacts = [Contact]()
            if success{
                for item in response{
                
                    let contact = Contact(id: item["_id"] as? String ?? "",
                        name: item["name"] as? String ?? "",
                        lastName: item["last_name"] as? String ?? "",
                        phone: item["phone"] as? String ?? "",
                        email: item["email"] as? String ?? "")
                    
                    contacts.append(contact)
                }
                
                completion(success: true, response: contacts)
                
            }else{
                
                completion(success: false, response: contacts)
            }
            
        }
    }
    
    class func saveContact(contact:Contact, completion:CompletionHandler){
        let parameters : [String: AnyObject] = ["name": contact.name!, "last_name": contact.lastName!, "phone":contact.phone!, "email":contact.email!]

        Request.sharedRequest.saveContact(parameters) { (success, response) in
            if success{
                completion(success: true, response: contact)
            }else{
                completion(success: false, response: contact)
            }
        }
    }
    
//    func deleteContact(index : Int, contactID: String, completion: CompletionHandler){
//        Request.sharedRequest.deleteContact(contactID) { (success, response) in
//            if success{
//                
//                self.contacts.removeAtIndex(index)
//                completion(success: true, response: self.contacts)
//                
//            }else{
//                
//                completion(success: false, response: self.contacts)
//            }
//
//        }
//    }
//    
    
    
    class func updateContact(contact: Contact, completion: CompletionHandler){
        let parameters : [String: AnyObject] = ["name": contact.name!, "last_name": contact.lastName!, "phone":contact.phone!, "email":contact.email!]
        
        Request.sharedRequest.updateContact(contact.id!, parameters: parameters, completion: { (success, response) in
            if success{
                
                completion(success: true, response: contact)
                
            }else{
                
                completion(success: false, response: contact)
            }
        })
    }

}

 