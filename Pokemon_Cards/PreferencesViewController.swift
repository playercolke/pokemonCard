//
//  PreferencesViewController.swift
//  Pokemon_Cards
//
//  Created by 郑植 on 7/1/20.
//  Copyright © 2020 CSE 390. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    @IBOutlet weak var sortFieldPicker: UIPickerView!
    @IBOutlet weak var sortMethod: UISwitch!
    
    let sortOrderItems: Array<String> = ["name", "type", "npn", "strength"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortFieldPicker.dataSource = self
        sortFieldPicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let settings = UserDefaults.standard
        sortMethod.setOn(settings.bool(forKey: Constants.kSortAscending), animated: true)
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        for field in sortOrderItems {
            if field == sortField {
                sortFieldPicker.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        sortFieldPicker.reloadComponent(0)
    }
    
    @IBAction func sortMethodChanged(_ sender: Any) {
        let setting = UserDefaults.standard
        setting.set(sortMethod.isOn, forKey: Constants.kSortAscending)
        setting.synchronize()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Returns the # of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOrderItems.count
    }
    
    //Sets the value that is shown for each row in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
            return sortOrderItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: Constants.kSortField)
        settings.synchronize()
    }
}
