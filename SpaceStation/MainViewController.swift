//
//  MainViewController.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
}

