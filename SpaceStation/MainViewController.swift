//
//  MainViewController.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import UIKit
import CoreLocation

let palatinoFont = "Palatino"

struct ResponseObject: Codable {
    let data: [SatelliteItem]
}

struct SatelliteItem: Codable {
    let duration: Int
    let riseTime: Int
}

struct SatResource {
    let url:URL
    let parse: (Data) -> Data?
}

class MainViewController: UIViewController {
    
    var issTuple = (request:[String:Double], response:[Response]).self
    var issRequest = [String:Double]()
    var issResponse = [Response]()
    
    let requestLabel:UILabel = {
        var label = UILabel()
        label.text = "Request:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 18.0)
        label.textAlignment = .center
        return label
    }()
    
    let altitudeLabel:UILabel = {
        var label = UILabel()
        label.text = "Altitude:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    let dateTimeLabel:UILabel = {
        var label = UILabel()
        label.text = "Date & Time:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    let latitudeLabel:UILabel = {
        var label = UILabel()
        label.text = "Latitude:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    let longitudeLabel:UILabel = {
        var label = UILabel()
        label.text = "Latitude:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    let passesLabel:UILabel = {
        var label = UILabel()
        label.text = "Passes:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
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
    
    var locationManager = CLLocationManager()
    var locationCoordinate = CLLocationCoordinate2D()
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()
        self.title = "Space Station"
        buildUserInterface()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func getSatelliteData() {
        
        let lat = locationCoordinate.latitude; let lon = locationCoordinate.longitude
        let satelliteURIString = "http://api.open-notify.org/iss-pass.json?lat=\(lat)&lon=\(lon)"
        let url = URL(string:satelliteURIString)
        
        let satelliteResource = SatResource(url: url!) {(data) -> Data? in
            return data
        }
        
        SatelliteService().load(resource: satelliteResource) {result in
            DispatchQueue.main.async(execute: {
                if let errorDescription = result as? String {
                    let title = "Unable to Access Satellite Data"
                    let alert = UIAlertController(title: title, message: errorDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else if let jsonData = result as? Data {
                    let issTuple = self.disseminateJSON(data: jsonData)
                    self.issRequest = issTuple.request
                    self.issResponse = issTuple.response
                }
            })
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
            getSatelliteData()
        }
    }
}














