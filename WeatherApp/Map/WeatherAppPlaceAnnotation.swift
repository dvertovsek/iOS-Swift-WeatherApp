//
//  WeatherAppPlaceAnnotation.swift
//  WeatherApp
//
//  Created by Dare on 08/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import MapKit

class WeatherAppPlaceAnnotation: MKPointAnnotation {
    let place: OWMPlace
    init(place: OWMPlace) {
        self.place = place
        super.init()
    }
}
