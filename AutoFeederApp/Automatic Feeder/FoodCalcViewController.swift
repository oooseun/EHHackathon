//
//  FoodCalcViewController.swift
//  Automatic Feeder
//
//  Created by Qi Liao on 1/28/17.
//  Copyright © 2017 Qi Liao. All rights reserved.
//

import UIKit

class FoodCalcViewController: UIViewController {

    @IBOutlet weak var nameBrand: UITextField!
    
    @IBOutlet weak var cupCal: UITextField!
    @IBOutlet weak var timesFed: UITextField!
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
            //does calculation
            if let value1 = Shared.shared.targetWeight, let value2 = Shared.shared.initialWeight{
                let targetWeight = 3.0
                let initialWeight = value2
                if targetWeight < initialWeight {
                    let targetCal = 20 * initialWeight * 0.99
                    Shared.shared.targetCal = targetCal
                    var feedFreq: Double = Double(timesFed.text!)!
                    if feedFreq > 5 {
                        feedFreq = 5.0
                    }
                    let cups = ((targetCal / Double(cupCal.text!)!) / feedFreq)
                    let roundedCups = Double(round(1000*cups)/1000)
                    Shared.shared.cupsToDispense = roundedCups
                    Timer.scheduledTimer(timeInterval:1.0, target:self, selector: "repeatMessage", userInfo: nil, repeats: true)
                }
            }
        
        
    }
    
    func repeatMessage(){
        let cupString = String(Shared.shared.cupsToDispense) + "\n"
        serial.sendMessageToDevice(cupString)
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
