//
//  ISSEphemeris.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import Foundation

final class SatelliteService {
    final func load(resource: SatResource, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
               // completion(error.localizedDescription)
            }
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
}




