//
//  CalcViewController.swift
//  Automatic Feeder
//
//  Created by Qi Liao on 1/28/17.
//  Copyright © 2017 Qi Liao. All rights reserved.
//

import UIKit


final class Shared {
    static let shared = Shared() //lazy init, and it only runs once
    
    var stringValue : String!
    var boolValue   : Bool!
}


class CalcViewController: UIViewController {

    @IBOutlet weak var breedPicker: UIPickerView!
    
    @IBOutlet weak var sexPick: UISegmentedControl!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var calcButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        Shared.shared.stringValue = "13.3"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


