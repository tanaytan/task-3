//
//  ViewController.swift
//  TRY 102938237478
//
//  Created by richa tandon on 28/06/2019.
//  Copyright © 2019 Tanay Tandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var billField: UITextField?
    
    @IBOutlet weak var tipField: UITextField!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var pplPicker: UIPickerView!
    
    @IBOutlet var pplLabel: UILabel!
    
    @IBOutlet var finalLabel: UILabel!
    
    
    
    // Picker:
    let nums = [1,2,3,4,5,6,7,8,9,10]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(nums[row])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nums.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pplLabel.text = String(nums[row])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Do any additional setup after loading the view.
        billField?.delegate = self

    // Keyboard Notification Things
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
     
}

    
    deinit {
        // Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
   
    //Actions:
 
    
    @IBAction func tipValueChanged(_ sender: Any) {
        let valTip = Int(slider.value)
        tipField.text = "\(valTip)"
        self.view.endEditing(true)
    }
    
    
    //MAIN FUNCTIONS:
    func mainFunc(){
        
        guard let bill = Double(billField!.text!) else{
            print("Got bill")
            return}
        guard let ppl = Double(pplLabel!.text!) else {
            print("Got ppl")
            return}
        guard let tip = Double(tipField.text!) else {
            print("Got tip")
            return}
        let total = calculateIt(bill: bill, ppl: ppl, tip: tip)
        finalLabel.text = "$" + String(total) + "per Person!"
    }
    
    func calculateIt(bill: Double, ppl: Double, tip: Double)-> Double{
        return (bill * (1 + (tip/100.0))) / ppl
    }
 
    
    //Delegate Stuff:
    
    @objc func keyboardWillChange(notification: Notification){
        print("Keyboard will show: \(notification.name.rawValue)")
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -50
        } else {
            view.frame.origin.y = 0
        }
    }
   
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
