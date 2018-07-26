//
//  ScanBLETableViewController.swift
//  RoboCarTest
//
//  Created by El Capitan on 7/24/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScanBLETableViewController: UITableViewController, CBCentralManagerDelegate {
   
    var peripherals: [CBPeripheral] = []
    var parentView: ViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        scanDevices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "device", for: indexPath)
        
        cell.textLabel?.text = peripherals[indexPath.row].name
        cell.detailTextLabel?.text = "UUID: \(peripherals[indexPath.row].identifier)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = peripherals[indexPath.row]
        Bluetooth.Device.manager?.connect(peripheral, options: nil)
    }
 
    func scanDevices() {
        Bluetooth.Device.manager?.scanForPeripherals(withServices: nil, options: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.stopScan()
        }
    }
    
    func stopScan() {
        Bluetooth.Device.manager?.stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (!peripherals.contains(peripheral)) {
            peripherals.append(peripheral)
        }
        
        self.tableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = parentView
        peripheral.discoverServices(nil)
        
        Bluetooth.Device.manager?.delegate = parentView
        Bluetooth.Device.peripheral = peripheral
        
        print("Connected to \(peripheral.identifier)")
        parentView?.LabelOut.text = "Connected"
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
