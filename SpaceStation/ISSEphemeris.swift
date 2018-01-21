//
//  ISSEphemeris.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/20/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import Foundation

final class SatelliteService {
    final func load<A>(resource: SatResource<A>, completion: @escaping (A?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            if let data = data {
                completion(resource.parse(data))
            } else {
                completion(nil)
            }
        }.resume()
    }
}




