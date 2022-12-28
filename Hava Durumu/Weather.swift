//
//  Weather.swift
//  Hava Durumu
//
//  Created by Halil YAŞ on 28.12.2022.
//

import Foundation

struct Weather {
    let currently : CurrentWeather
}

extension Weather {
    
    init?(json : [String : AnyObject]) {
        guard let currentWeatherJson = json["currently"] as? [String : AnyObject],
              let currentWeather = CurrentWeather(json: currentWeatherJson) else { return nil }
        self.currently = currentWeather
    }
}
