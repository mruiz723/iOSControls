//
//  PickersViewController.swift
//  iOSControls
//
//  Created by mruiz723 on 4/7/16.
//  Copyright © 2016 Udem. All rights reserved.
//

import UIKit

class PickersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: - IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var citiesPickerView: UIPickerView!
    
    //MARK: - Properties
    var data:NSArray?
    
    //MARK: - IBOActions
    @IBAction func date(sender: AnyObject) {
        dateLabel.text = "\(datePicker.date)"
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let path = NSBundle.mainBundle().pathForResource("Cities", ofType: "plist"){
            data = NSArray(contentsOfFile: path)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (data?.count)!
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data![row] as? String
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(data![row])
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
