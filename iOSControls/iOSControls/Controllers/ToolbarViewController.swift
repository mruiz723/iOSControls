//
//  ToolbarViewController.swift
//  iOSControls
//
//  Created by mruiz723 on 4/7/16.
//  Copyright © 2016 Udem. All rights reserved.
//

import UIKit

class ToolbarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var contactTable: UITableView!
    
    
    //MARK: - Properties
    var contacts: [Contact]?
    var contact: Contact?
    var selectedContact = false
    
    //MARK: - IBActions
    @IBAction func cancel(sender: AnyObject) {
        makeAlert("Cancel")
    }
    
    @IBAction func edit(sender: AnyObject) {
        if selectedContact{
            selectedContact = false
            performSegueWithIdentifier("detail", sender: nil)
        }
    }
    
    @IBAction func add(sender: AnyObject) {
        contact = nil
        performSegueWithIdentifier("detail", sender: nil)
    }
    
    @IBAction func remove(sender: AnyObject) {
        makeAlert("Remove")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Contact.getContacts({ (success, response) in
            self.contacts = response
            self.contactTable.reloadData()
        })
        // Do any additional setup after loading the view.
//        navigationController?.setToolbarHidden(false, animated: false)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    ///*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let detailVC = segue.destinationViewController as? DetailViewController{
            if contact == nil {
                contact = Contact()
            }else{
                detailVC.isUpdateAction = true
            }
            detailVC.contact = contact
            detailVC.delegate = self
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let contacts = contacts{
            return contacts.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        contact = contacts![indexPath.row]
        
        let cell = contactTable.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = "\(contact!.name!) \(contact!.lastName!)"
        cell?.detailTextLabel?.text = "\(contact!.phone!)"
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        contact = contacts![indexPath.row]
        selectedContact = true
    }
    
    //MARK: - Utils
    func makeAlert(message:String) {
        let alertVC = UIAlertController(title: "Acción", message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: message, style: .Default) { (action) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertVC.addAction(okAction)
        
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    //MARK: - DetailViewControllerDelegate
    
    func didChangeContacts(typeOfChange:String){
        
        if typeOfChange == "new"{
            contacts?.append(contact!)
        }
        contactTable.reloadData()
    }
    
    

}
