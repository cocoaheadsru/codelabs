//
//  SettingsViewController.swift
//  Rainy
//
//  Created by Kirill Averyanov on 30/10/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var swifthLocation: UISwitch!
    
    private var setts = UserDefaults.standard
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = setts.value(forKey: "cityName") {
            textField.text = String(describing: name)
        }
        else {
            textField.text = "Saint Petersburg"
        }
    }
    
    // MARK: UIResponser methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    // MARK: IBActions
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        setts.set(textField.text!, forKey: "cityName")
    }
}
