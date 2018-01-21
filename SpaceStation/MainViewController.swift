//
//  MainViewController.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import UIKit
import CoreLocation

struct SatResource {
    let url:URL
    let parse: (Data) -> Data?
}

class MainViewController: UIViewController {
    let titleLabel:UILabel = {
        var label = UILabel()
        label.text = "My Project"
        label.textColor = UIColor.purple
        label.font = UIFont(name: "Space Station", size: 23.0)
        label.textAlignment = .center
        return label
    }()
    
    let toolBar:UIToolbar = {
        var toolbar = UIToolbar()
        var items = [UIBarButtonItem]()
        let item1 = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(exitAction))
        let item2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: #selector(toolbarHandler))
        let item3 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(toolbarHandler))
        
        items = [item1, item2, item3]
        
        toolbar.items = items
        return toolbar
    }()
    
    func buildUserInterface() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          bottom: nil,
                          left: nil,
                          right: nil,
                          centerYAnchor: nil,
                          centerXAnchor: view.safeAreaLayoutGuide.centerXAnchor,
                          paddingTop: -130,
                          paddingLeft: 10,
                          paddingBottom: 10,
                          paddingRight: 10, width: 100.0, height: 320)
        
        view.addSubview(toolBar)
        toolBar.anchor(top: nil,
                       bottom: view.safeAreaLayoutGuide.bottomAnchor,
                       left: view.safeAreaLayoutGuide.leftAnchor,
                       right: view.safeAreaLayoutGuide.rightAnchor,
                       centerYAnchor: nil,
                       centerXAnchor: nil,
                       paddingTop: 0,
                       paddingLeft: 0,
                       paddingBottom: 0,
                       paddingRight: 0,
                       width: 0)
        
        view.backgroundColor = UIColor.skyBlue()
    }
    
    var locationManager = CLLocationManager()
    var locationCoordinate = CLLocationCoordinate2D()
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUserInterface()
        self.title = "Space Station"
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        //        if CLLocationManager.locationServicesEnabled() {
        //            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
        //                print("*** Location Services Denied ***")
        //            } else if CLLocationManager.authorizationStatus() == .notDetermined {
        //
        //                locationManager.requestWhenInUseAuthorization()
        //
        //            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        //                print("*** Okay Good to go. ***")
        //                locationManager.requestLocation()
        //            }
        //        } else {
        //            print("Location services NOT enabled.")
        //        }
        
        doSomething()
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func doSomething() {
        
        // http://api.open-notify.org/iss-pass.json?lat=37.332331410000002&lon=37.332331410000002
        
        let url = URL(string: "http://api.open-notify.org/iss-pass.json?lat=37.332331410000002&lon=37.332331410000002")
        
        let satelliteResource = SatResource(url: url!) {(data) -> Data? in
            print("...this is where you parse the data. ****")
            return data
        }
        
        SatelliteService().load(resource: satelliteResource) {result in
            
            if result != nil {
                if let deserialised = try? JSONSerialization.jsonObject(with: result!, options: []) {
                    print(deserialised)
                }
            }
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action & Handlers
    
    @objc func exitAction() {
        exit(0)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @objc func toolbarHandler() {
        print("Toolbar item handler.")
    }
}

// ===================================================================================================

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** Location Failure ***")
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard locations.count > 0 else {
            print("*** Sorry, No Location Found ***")
            return
        }
        if let myLocation = locations.first?.coordinate {
            locationCoordinate = myLocation
        }
    }
}














