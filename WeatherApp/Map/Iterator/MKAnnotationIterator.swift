//
//  PlacesSequenceIterator.swift
//  WeatherApp
//
//  Created by Dare on 07/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import MapKit

struct PlacesSequence: Sequence {
    let places: [OWMPlace]

    func makeIterator() -> MapItemsIterator {
        return MapItemsIterator(self)
    }
}

struct MapItemsIterator: IteratorProtocol {
    let placesSeq: PlacesSequence
    var index = 0

    init(_ placesSeq: PlacesSequence) {
        self.placesSeq = placesSeq
    }

    mutating func next() -> MKPointAnnotation? {
        let nextPlace = placesSeq.places[index]
        index += 1
        if index >= placesSeq.places.count { return nil }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: nextPlace.coord.lat,
                                                       longitude: nextPlace.coord.lon)
        annotation.title = nextPlace.name
        let temp = nextPlace.weather?.data.temp ?? 0.0
        let description = nextPlace.weather?.description.first?.description ?? ""
        annotation.subtitle = "\(temp)˚C, "+description
        return annotation
    }
}
