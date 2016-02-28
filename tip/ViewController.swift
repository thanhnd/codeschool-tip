//
//  ViewController.swift
//  tip
//
//  Created by Thanh Nguyen on 1/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SettingProtocol {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var selectTipIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        let defaults = NSUserDefaults.standardUserDefaults()
        selectTipIndex = defaults.integerForKey("default_tip")
        
        billField.delegate = self
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
        print("onEditingChanged")
        let tipPercentages = [0.18, 0.2, 0.22]
        selectTipIndex = tipControl.selectedSegmentIndex
        let tipPercentage = tipPercentages[selectTipIndex]

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
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String)
        -> Bool
    {
        // We ignore any change that doesn't add characters to the text field.
        // These changes are things like character deletions and cuts, as well
        // as moving the insertion point.
        //
        // We still return true to allow the change to take place.
        if string.characters.count == 0 {
            return true
        }
        
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        return prospectiveText.containsOnlyCharactersIn("0123456789.,")
        
    }
}

