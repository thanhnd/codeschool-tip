//
//  SettingsViewController.swift
//  tip
//
//  Created by Thanh Nguyen on 1/31/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol SettingProtocol {
    func setDefaultTipIndex(tipIndex: Int)
}

class SettingsViewController: UIViewController {
    
    var delegate:SettingProtocol?

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("default_tip")
        tipControl.selectedSegmentIndex = intValue;
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

    @IBAction func onValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = tipControl.selectedSegmentIndex
        defaults.setInteger(tipIndex, forKey: "default_tip")
        defaults.synchronize()
        
        delegate?.setDefaultTipIndex(tipIndex)
    }
}
