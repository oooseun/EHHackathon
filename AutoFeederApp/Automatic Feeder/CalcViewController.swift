//
//  CalcViewController.swift
//  Automatic Feeder
//
//  Created by Qi Liao on 1/28/17.
//  Copyright © 2017 Qi Liao. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {

    @IBOutlet weak var breedPicker: UIPickerView!
    
    @IBOutlet weak var sexPick: UISegmentedControl!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var calcButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "segueTest") {
            let svc = segue!.destination as! WeightViewController
            
            svc.toPass = "hello"
            
        }
    }

}
