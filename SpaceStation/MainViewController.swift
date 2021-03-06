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
    let riseTime: Double
}

struct SatResource {
    let url:URL
    let parse: (Data) -> Data?
}

class MainViewController: UIViewController {
    let gSpinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var issTuple = (request:[String:Double], response:[Response]).self
    var issRequest = [String:Double]()
    var issResponse = [Response]()
    
    // Request Label:
    let requestLabel:UILabel = {
        var label = UILabel()
        label.text = "Request:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 18.0)
        label.textAlignment = .center
        return label
    }()
    
    // Altitude:
    let altitudeLabel:UILabel = {
        var label = UILabel()
        label.text = "Altitude:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    // Date & Time:
    let dateTimeLabel:UILabel = {
        var label = UILabel()
        label.text = "Date & Time:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    // Latitude:
    let latitudeLabel:UILabel = {
        var label = UILabel()
        label.text = "Latitude:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    // Longitude:
    let longitudeLabel:UILabel = {
        var label = UILabel()
        label.text = "Longitude:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    // Passes:
    let passesLabel:UILabel = {
        var label = UILabel()
        label.text = "Passes:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 14.0)
        label.textAlignment = .left
        return label
    }()
    
    // Tabeview title:
    let ephemerisLabel:UILabel = {
        var label = UILabel()
        label.text = "ISS Ephemeris:"
        label.textColor = UIColor.purple
        label.font = UIFont(name: palatinoFont, size: 18.0)
        label.textAlignment = .left
        return label
    }()
    
    // Tableview:
    let tableView: UITableView = {
        let table = UITableView()
        table.scrollsToTop = false
        table.bounces = false
        table.isScrollEnabled = false
        table.backgroundColor = UIColor.clear
        return table
    }()
    
    // Toolbar:
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
    
    let dateFormatter = DateFormatter()
    var locationManager = CLLocationManager()
    var locationCoordinate = CLLocationCoordinate2D()
    let cellID = "cell"
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        gSpinner.color = UIColor.purple
        gSpinner.center = self.view.center
        self.view.addSubview(gSpinner)
        gSpinner.startAnimating()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm:ss")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()
        
        self.title = "International Space Station Pass Times"
        
        buildUserInterface()
        tableView.dataSource = self
        tableView.rowHeight = 62.0
        let myNib = UINib(nibName:"TableViewCell",bundle:nil)
        tableView.register(myNib, forCellReuseIdentifier:cellID)
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
                    self.populateRequestFields()
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
        tableView.reloadData()
    }
}

// ===================================================================================================
// MARK: -

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for:indexPath) as! ISSCell
        cell.duration.text = "Duration: \(issResponse[indexPath.row].duration.duration())"
        cell.riseTime.text = "Rise Time: \(issResponse[indexPath.row].risetime.timeStamp())"
        return cell
    }
}
    
// ===================================================================================================
// MARK: -

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        gSpinner.stopAnimating()
        let title = "Location Manager Error"
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        gSpinner.stopAnimating()
        guard locations.count > 0 else {
            let title = "Sorry, No Location Found"
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if let myLocation = locations.first?.coordinate {
            locationCoordinate = myLocation
            getSatelliteData()
        }
    }
}














