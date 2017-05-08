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
    var selectedAnnotation: MKPointAnnotation?

    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapType = .hybridFlyover
        mapView.delegate = self
        dataManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let placesSeq = PlacesSequence(places: dataManager.myPlaces)
        for annotation in placesSeq {
            mapView.addAnnotation(annotation)
        }
    }

}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard
            let weatherAnnotation = view.annotation as? WeatherAppPlaceAnnotation
            else { return }
        selectedAnnotation = weatherAnnotation
        dataManager.getWeather(for: weatherAnnotation.place)
    }

}

extension MapViewController: DataManagerResultDelegate {

    func didReturnResults(weather: OWMWeather) {
        let temp = "\(weather.data.temp)˚C, "
        let desc = weather.description.first?.description ?? ""
        selectedAnnotation?.subtitle = temp + desc
    }

    func didReturnError(_ error: Error) {
        selectedAnnotation?.subtitle = error.localizedDescription
    }
    
}
