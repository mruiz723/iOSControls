//
//  Contacts.swift
//  ExampleAlamofirePUTDELETE
//
//  Created by Laura Mejia Arroyave on 2/24/16.
//  Copyright © 2016 NextU. All rights reserved.
//

import UIKit



class Contact {
    
    typealias CompletionHandler = (success: Bool, response: [Contact]) ->()
    
    //MARK: - Properties
    var id: String?
    var name: String?
    var lastName: String?
    var phone: String?
    var email: String?
    let request: Request = Request()
    var contacts = [Contact]()
    
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
    
    func getContacts(completion: CompletionHandler){
        
        request.getContacts { (success, response) -> () in
            
            if success{
                
                self.contacts.removeAll()
                
                for item in response{
                    
                    let contact = Contact(id: item["_id"] as? String ?? "",
                                        name: item["name"] as? String ?? "",
                                        lastName: item["last_name"] as? String ?? "",
                                        phone: item["phone"] as? String ?? "",
                                        email: item["email"] as? String ?? "")
                    
                    self.contacts.append(contact)
                }
                
                completion(success: true, response: self.contacts)
                
            }else{
                
                completion(success: false, response: self.contacts)
            }
            
        }
    }
    
    func saveContact(contact: Contact, completion:CompletionHandler){
        let parameters : [String: AnyObject] = ["name": contact.name!, "last_name": contact.lastName!, "phone":contact.phone!, "email":contact.email!]
        
        request.saveContact(parameters) { (success, response) -> () in
            if success{
                self.contacts.append(contact)
                completion(success: true, response: self.contacts)
            }else{
                completion(success: false, response: self.contacts)
            }
            
        }
    }
    
    func deleteContact(index : Int, contactID: String, completion: CompletionHandler){
        
        request.deleteContact(contactID) { (success, response) -> () in
            
            if success{
                
                self.contacts.removeAtIndex(index)
                completion(success: true, response: self.contacts)
                
            }else{
                
                completion(success: false, response: self.contacts)
            }
            
        }
    }
    
    func updateContact(contact : Contact, completion: CompletionHandler){
        
        
        let parameters : [String: AnyObject] = ["name": contact.name!, "last_name": contact.lastName!, "phone":contact.phone!, "email":contact.email!]
        
        request.updateContact(contact.id!, parameters: parameters) { (success, response) -> () in
            
            if success{
                
                for item in self.contacts{
                    
                    if item.id == contact.id!{
                        
                        item.name = contact.name
                        item.lastName = contact.lastName
                        item.phone = contact.phone
                        item.email = contact.email
                    }
                }
                
                completion(success: true, response: self.contacts)
                
            }else{
                
                completion(success: false, response: self.contacts)
            }
            
        }
    }
}

 