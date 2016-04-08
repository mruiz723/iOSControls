//
//  ViewController.swift
//  iOSControls
//
//  Created by mruiz723 on 4/7/16.
//  Copyright © 2016 Udem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - IBOutlets
    @IBOutlet weak var controlsTableView: UITableView!
    
    
    //MARK: - Properties
    var menuItems:[String]?
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menuItems = ["Toolbar", "ImageView", "Pickers", "Slider", "Switch", "CustomFonts", "ScrollView"]
        navigationController?.setToolbarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menuItems?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = controlsTableView.dequeueReusableCellWithIdentifier("cell") {
            cell.textLabel?.text = menuItems![indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(menuItems![indexPath.row], sender: nil)
    }
    

}

