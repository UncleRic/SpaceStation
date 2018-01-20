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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUserInterface()
        self.title = "Space Station"
        locationManager.delegate = self
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

