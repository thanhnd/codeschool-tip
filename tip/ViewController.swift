//
//  ViewController.swift
//  tip
//
//  Created by Thanh Nguyen on 1/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingProtocol {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var selectTipIndex: Int = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        let defaults = NSUserDefaults.standardUserDefaults()
        selectTipIndex = defaults.integerForKey("default_tip")
    }
    
    override func viewWillAppear(animated: Bool) {
        tipControl.selectedSegmentIndex = selectTipIndex;
        tipControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", arguments: [tip])
        totalLabel.text = String(format: "$%.2f", arguments: [total])
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // MARK: SettingProtocol functions
    func setDefaultTipIndex(tipIndex: Int) {
        selectTipIndex = tipIndex
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "settingSegue"{
            let settingsVC = segue.destinationViewController as! SettingsViewController
            settingsVC.delegate = self
        }
    }
}

