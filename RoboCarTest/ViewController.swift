//
//  ViewController.swift
//  RoboCarTest
//
//  Created by El Capitan on 7/24/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    @IBOutlet weak var LabelOut: UILabel!
    
    var mainCharacteristic: CBCharacteristic? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bluetooth.Device.manager = CBCentralManager(delegate: self, queue: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScanSegue" {
            let scanController :  ScanBLETableViewController = segue.destination as! ScanBLETableViewController
            Bluetooth.Device.manager?.delegate = scanController
            scanController.parentView = self
        }
    }
    
    @IBAction func ScanButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ScanSegue", sender: self)
    }
    
    @IBAction func moveForward(_ sender: UIButton) {
        let command = "f"
        let dataToSend = command.data(using: String.Encoding.utf8)
        
        if Bluetooth.Device.peripheral != nil {
            Bluetooth.Device.peripheral?.writeValue(dataToSend!, for: mainCharacteristic!, type: .withoutResponse)
        }
        
    }
    
    @IBAction func moveBackward(_ sender: UIButton) {
        let command = "b"
        let dataToSend = command.data(using: String.Encoding.utf8)
        
        if Bluetooth.Device.peripheral != nil {
            Bluetooth.Device.peripheral?.writeValue(dataToSend!, for: mainCharacteristic!, type: .withoutResponse)
        }
    }
    
    @IBAction func turnLeft(_ sender: UIButton) {
        let command = "l"
        let dataToSend = command.data(using: String.Encoding.utf8)
        
        if Bluetooth.Device.peripheral != nil {
            Bluetooth.Device.peripheral?.writeValue(dataToSend!, for: mainCharacteristic!, type: .withoutResponse)
        }
    }
    
    @IBAction func turnRight(_ sender: UIButton) {
        let command = "r"
        let dataToSend = command.data(using: String.Encoding.utf8)
        
        if Bluetooth.Device.peripheral != nil {
            Bluetooth.Device.peripheral?.writeValue(dataToSend!, for: mainCharacteristic!, type: .withoutResponse)
        }
    }
    
    @IBAction func stop(_ sender: UIButton) {
        let command = "s"
        let dataToSend = command.data(using: String.Encoding.utf8)
        
        if Bluetooth.Device.peripheral != nil {
            Bluetooth.Device.peripheral?.writeValue(dataToSend!, for: mainCharacteristic!, type: .withoutResponse)
        }
    }
    
    
}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        Bluetooth.Device.peripheral = nil
        print("Disconnected" + peripheral.name!)
        LabelOut.text = "Disconnected"
    }
}

extension ViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        for service in peripheral.services! {
            print("Servce found with UUID: " + service.uuid.uuidString)
            peripheral.discoverCharacteristics(nil, for: service)
        }
        print("***")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristics")
        
        for characteristic in service.characteristics! {
            peripheral.readValue(for: characteristic)
            print("Found Device Name Characteristic \(characteristic.uuid)")
            mainCharacteristic = characteristic
        }
        print("***")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        let deviceName = descriptor.value
        print("Device Name")
        print(deviceName ?? "No Device Name")
    }
}
