//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Dare on 03/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapType = .satelliteFlyover
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let placesSeq = PlacesSequence(places: dataManager.myPlaces)
        for annotation in placesSeq {
            mapView.addAnnotation(annotation)
        }
    }

}
