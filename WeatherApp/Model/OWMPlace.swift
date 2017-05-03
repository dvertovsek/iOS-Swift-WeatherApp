//
//  OWMPlace.swift
//  WeatherApp
//
//  Created by Dare on 4/15/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import Marshal

struct OWMPlace {

    var id: Int
    var name: String
    var country: String
    var coord: Coordinate

    var weather: OWMWeather?

}

extension OWMPlace: Unmarshaling {

    init(object: MarshaledObject) throws {
        id = try object.value(for: "_id")
        name = try object.value(for: "name")
        country = try object.value(for: "country")
        coord = try object.value(for: "coord")
    }
}

struct Coordinate: Unmarshaling {
    var lon: Double
    var lat: Double

    init(object: MarshaledObject) throws {
        lon = try object.value(for: "lon")
        lat = try object.value(for: "lat")
    }
}
