//
//  BLEController.swift
//  RoboCarTest
//
//  Created by El Capitan on 7/25/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit
import CoreBluetooth

class Bluetooth  {
    static let Device = Bluetooth()
    private init() { }
    
    var manager: CBCentralManager?
    var peripheral: CBPeripheral?
}
