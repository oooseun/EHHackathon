//
//  WeightViewController.swift
//  Automatic Feeder
//
//  Created by Qi Liao on 1/28/17.
//  Copyright © 2017 Qi Liao. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {
    var toPass:String!

    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var weightStepper: UIStepper!
    
    @IBOutlet weak var calCup: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weightStepper.wraps = true
        self.weightStepper.autorepeat = true
        self.weightLabel.text = String(0.0)
        self.weightStepper.stepValue = 0.1
        
        self.weightStepper.maximumValue = 10;
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperValueChange(_ sender: UIStepper) {
        weightLabel.text = Double(sender.value).description
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
