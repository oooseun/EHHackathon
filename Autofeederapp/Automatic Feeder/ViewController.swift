//
//  ViewController.swift
//  Automatic Feeder
//
//  Created by Qi Liao on 1/27/17.
//  Copyright © 2017 Qi Liao. All rights reserved.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController,BluetoothSerialDelegate {
    // The peripherals that have been discovered (no duplicates and sorted by asc RSSI)
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    @IBOutlet weak var connectButtonUI: UIButton!
    @IBOutlet weak var catWeightView: UILabel!

    @IBAction func connectButton(_ sender: Any) {
        if serial.centralManager.state != .poweredOn {
            let alert = UIAlertController(title: "Turn on Bluetooth", message: "", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            
            alert.addAction(OKAction)
            
            self.present(alert, animated: true) {
            }
        } else {
            
            serial.startScan()
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.scanTimeOut), userInfo: nil, repeats: false)
        }
    }
    
    // Should be called 10s after we've begun scanning
    func scanTimeOut() {
        // timeout has occurred, stop scanning and give the user the option to try again
        serial.stopScan()
    }
    
    //MARK: BluetoothSerialDelegate
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        for existing in peripherals {
            if existing.peripheral.identifier == peripheral.identifier {
                serial.connectToPeripheral(existing.peripheral)
            }
        }
        serial.stopScan() //Can be problematic
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append(peripheral: peripheral, RSSI: theRSSI)
        peripherals.sort { $0.RSSI < $1.RSSI }
        
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        connectButtonUI.titleLabel?.text = "Connect"
        
    }
    
    func serialDidConnect(_ peripheral: CBPeripheral) {
        connectButtonUI.titleLabel?.text = "Connected"
        print("Connected to ",peripheral.name ?? "Bluetooth device")
    }
    
    func serialDidChangeState(central:CBCentralManager) {
        if central.state == .poweredOn{
            print("Bluetooth ON")
            serial.startScan()
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.scanTimeOut), userInfo: nil, repeats: false)
        }
    }

    func serialDidReceiveData(_ data: Data){
        //Called when data is recieved.
        let weight:String = (NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "") as String
        print(weight)
        catWeightView.text = weight
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // init serial
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .withResponse
        serial.delegate = self
        
        // start scanning and schedule the time out
        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.scanTimeOut), userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        serial.sendMessageToDevice("JASONNNNNNNNNNNNNN")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

