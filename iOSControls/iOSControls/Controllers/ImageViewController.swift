//
//  ImageViewController.swift
//  iOSControls
//
//  Created by mruiz723 on 4/7/16.
//  Copyright © 2016 Udem. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - IBActions
    @IBAction func swithChange(sender: UISwitch) {
        if sender.on {
            imageView.image = UIImage(named: "126H.jpg")
        }else{
            let path = NSBundle.mainBundle().pathForResource("225H", ofType: "jpg")
            imageView.image = UIImage(contentsOfFile:path!)
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "225H.jpg")

        // Do any additional setup after loading the view.
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
