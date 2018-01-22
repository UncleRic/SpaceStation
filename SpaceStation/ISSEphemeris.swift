//
//  ISSEphemeris.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import Foundation
import UIKit

final class SatelliteService {
    final func load(resource: SatResource, completion: @escaping (Any?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
               completion(error.localizedDescription)
            } else if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

// ===================================================================================================

extension MainViewController {
    
    public struct Response: Codable {
        let duration : Int
        let risetime : Double
    }
    
    public struct Request: Codable {
        let altitude: Int
        let datetime : Double
        let latitude : Double
        let longitude: Double
        let passes: Int
    }
    
    public struct DataListModel: Codable {
        let request : [String:Double]
        let response : [Response]
    }
    
    func disseminateJSON(data: Data) -> (request:[String:Double], response:[Response]) {
        var issFlightArray = [Response]()
        var requestArray = [String:Double]()
        do {
            let issFlight = try JSONDecoder().decode(DataListModel.self, from: data)
            
            issFlightArray = issFlight.response
            requestArray = issFlight.request
            
        } catch let error as NSError {
            let title = "JSON Dissemination Error"
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return (requestArray, issFlightArray)
    }
}




