//
//  ISSEphemeris.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import Foundation

final class SatelliteService {
    final func load(resource: SatResource, completion: @escaping (Any?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
               completion(error.localizedDescription)
            }
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

// ===================================================================================================

extension MainViewController {
    
    public struct response: Codable {
        let duration : Int
        let risetime : Double
    }
    
    public struct request: Codable {
        let altitude: Int
        let datetime : Double
        let latitude : Double
        let longitude: Double
        let passes: Int
    }
    
    public struct DataListModel: Codable {
        let request : [String:Double]
        let response : [response]
    }
    
    func disseminateJSON(data: Data) {
        do {
            let ssbFlight = try JSONDecoder().decode(DataListModel.self, from: data)
            
            let modelArray = ssbFlight.response
            let requestArray = ssbFlight.request
            
            for item in requestArray {
                print(item)
            }
            print("------------------")
            
            for item in modelArray {
                print("item.duration: \(item.duration); item.risetime: \(item.risetime)")
            }
            
        } catch let error as NSError {
            print("\(error)") //Error Domain=Swift.DecodingError Code=2 "(null)"
        }

    }
}




