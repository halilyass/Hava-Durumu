//
//  Coordinate.swift
//  Hava Durumu
//
//  Created by Halil YAŞ on 28.12.2022.
//

import Foundation

struct Coordinate {
    let latitude : Double
    let longitude : Double
    
}

extension Coordinate : CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
    
    static var alcatrazIslan : Coordinate {
        return Coordinate(latitude: 37.8267, longitude: -122.4233)
    }
}
