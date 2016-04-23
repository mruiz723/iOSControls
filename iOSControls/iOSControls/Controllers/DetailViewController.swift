//
//  DetailViewController.swift
//  iOSControls
//
//  Created by mruiz723 on 4/22/16.
//  Copyright © 2016 Udem. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func didChangeContacts(typeOfChange:String)
}

class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    
    // MARK: - Properties
    var contact:Contact?
    var delegate:DetailViewControllerDelegate?
    var isUpdateAction = true
    
    // MARK: - IBActions
    @IBAction func save(sender: UIButton) {
        if (nameLabel.text?.isEmpty)! != true{
            if (lastName.text?.isEmpty)! != true{
                if (phoneLabel.text?.isEmpty)! != true{
                    if (emailLabel.text?.isEmpty)! != true{
                        contact!.name = nameLabel.text
                        contact!.lastName = lastName.text
                        contact!.phone = phoneLabel.text
                        contact!.email = emailLabel.text
                        
                        if isUpdateAction {
                            Contact.updateContact(contact!) { (success, response) in
                                if success{
                                    self.delegate!.didChangeContacts("update")
                                    self.navigationController?.popViewControllerAnimated(true)
                                }
                            }
                        }else{
                            Contact.saveContact(contact!) { (success, response) in
                                if success{
                                    self.delegate!.didChangeContacts("new")
                                    self.navigationController?.popViewControllerAnimated(true)
                                }
                            }
                        }
                        
                        
                    }
                }
            }
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let contact = contact{
            nameLabel.text = contact.name
            lastName.text = contact.lastName
            phoneLabel.text = contact.phone
            emailLabel.text = contact.email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
