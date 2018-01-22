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
        view.addSubview(requestLabel)
        requestLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          bottom: nil,
                          left: view.safeAreaLayoutGuide.leftAnchor,
                          right: nil,
                          centerYAnchor: nil,
                          centerXAnchor: nil,
                          paddingTop: -130,
                          paddingLeft: 0,
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
}

