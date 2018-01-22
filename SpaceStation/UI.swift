//
//  UI.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/21/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    
    func buildUserInterface() {
        let requestTopPadding:CGFloat = 20.0
        let requestLeftPadding:CGFloat = 0.0
        
        // Request Label:
        view.addSubview(requestLabel)
        requestLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            bottom: nil,
                            left: view.safeAreaLayoutGuide.leftAnchor,
                            right: nil,
                            centerYAnchor: nil,
                            centerXAnchor: nil,
                            paddingTop: requestTopPadding,
                            paddingLeft: 0,
                            paddingBottom: 10,
                            paddingRight: 10, width: 100.0, height: 24)
        
        // Altitude Label:
        view.addSubview(altitudeLabel)
        altitudeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             bottom: nil,
                             left: view.safeAreaLayoutGuide.leftAnchor,
                             right: nil,
                             centerYAnchor: nil,
                             centerXAnchor: nil,
                             paddingTop: requestTopPadding + 20,
                             paddingLeft: requestLeftPadding + 40,
                             paddingBottom: 10,
                             paddingRight: 10, width: 200.0, height: 24)
        
        // Date & Time Label:
        view.addSubview(dateTimeLabel)
        dateTimeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             bottom: nil,
                             left: view.safeAreaLayoutGuide.leftAnchor,
                             right: nil,
                             centerYAnchor: nil,
                             centerXAnchor: nil,
                             paddingTop: requestTopPadding + 40,
                             paddingLeft: requestLeftPadding + 40,
                             paddingBottom: 10,
                             paddingRight: 10, width: 200.0, height: 24)
        
        // Latitude Label:
        view.addSubview(latitudeLabel)
        latitudeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             bottom: nil,
                             left: view.safeAreaLayoutGuide.leftAnchor,
                             right: nil,
                             centerYAnchor: nil,
                             centerXAnchor: nil,
                             paddingTop: requestTopPadding + 60,
                             paddingLeft: requestLeftPadding + 40,
                             paddingBottom: 10,
                             paddingRight: 10, width: 200.0, height: 24)
        
        // Longitude Label:
        view.addSubview(longitudeLabel)
        longitudeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              bottom: nil,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              right: nil,
                              centerYAnchor: nil,
                              centerXAnchor: nil,
                              paddingTop: requestTopPadding + 80,
                              paddingLeft: requestLeftPadding + 40,
                              paddingBottom: 10,
                              paddingRight: 10, width: 200.0, height: 24)
        
        // Passes Label:
        view.addSubview(passesLabel)
        passesLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           bottom: nil,
                           left: view.safeAreaLayoutGuide.leftAnchor,
                           right: nil,
                           centerYAnchor: nil,
                           centerXAnchor: nil,
                           paddingTop: requestTopPadding + 100,
                           paddingLeft: requestLeftPadding + 40,
                           paddingBottom: 10,
                           paddingRight: 10, width: 200.0, height: 24)
        
        // Ephemeris Label:
        view.addSubview(ephemerisLabel)
        ephemerisLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            bottom: nil,
                            left: view.safeAreaLayoutGuide.leftAnchor,
                            right: nil,
                            centerYAnchor: nil,
                            centerXAnchor: nil,
                            paddingTop: requestTopPadding + 140,
                            paddingLeft: requestLeftPadding + 20,
                            paddingBottom: 10,
                            paddingRight: 10, width: 200.0, height: 24)
        
        // UITableView:
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           left: view.safeAreaLayoutGuide.leftAnchor,
                           right: view.safeAreaLayoutGuide.rightAnchor,
                           centerYAnchor: nil,
                           centerXAnchor: nil,
                           paddingTop: requestTopPadding + 170,
                           paddingLeft: requestLeftPadding + 40,
                           paddingBottom: -140,
                           paddingRight: -20, width: 0.0, height: 0.0)
        
       
        // Toolbar Label:
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
    
    // -----------------------------------------------------------------------------------------------------
    
    func populateRequestFields() {
        if let alt = issRequest["altitude"] {
            altitudeLabel.text = "Altitude: \(alt) meters."
        }
        
        if let latitude = issRequest["latitude"] {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 2
        
            if let lat = numberFormatter.string(from: NSNumber(value:latitude)) {
                latitudeLabel.text = "Latitude: \(lat) degrees"
            }
        }
        
        if let longitude = issRequest["longitude"] {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 2
            
            if let long = numberFormatter.string(from: NSNumber(value:longitude)) {
                longitudeLabel.text = "Latitude: \(long) degrees"
            }
        }
        
        if let passes = issRequest["passes"] {
            passesLabel.text = "Passes: \(Int(passes))"
        }
        
    }
}

