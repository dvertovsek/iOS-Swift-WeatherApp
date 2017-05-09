//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Dare on 03/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!

    @IBOutlet weak var weatherDetailDescriptionLabel: UILabel!

    @IBOutlet weak var placeImageView: UIImageView!

    var place: OWMPlace?

    var dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager.weatherDelegate = self
        dataManager.photoDelegate = self

        guard let place = place else { return }
        dataManager.getPhoto(for: place.name)
        navBar.topItem?.title = "Weather in \(place.name)"
        guard let weather = place.weather else {
            dataManager.getWeather(for: place)
            return
        }
        setupWeatherLabels(with: weather)
    }

    func setupWeatherLabels(with weather: OWMWeather) {
        temperatureLabel.text = "\(weather.data.temp)˚C"
        weatherImageView.kf.setImage(with: weather.description.first?.iconUrl)
        weatherDescriptionLabel.text = weather.description.first?.description
        weatherDetailDescriptionLabel.text = weather.description.first?.detailDescription
    }

    @IBAction func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }

}

extension WeatherDetailsViewController: OWMWeatherResultDelegate {

    func didReturnResults(weather: OWMWeather) {
        setupWeatherLabels(with: weather)
    }

    func didReturnWeatherError(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }

}

extension WeatherDetailsViewController: FlickrPhotoResultDelegate {

    func didReturnPhotoUrl(with url: URL?) {
        setPhoto(with: url)
    }

    func didReturnPhotoError(_ error: Error) {
        setPhoto(with: URL.randomCityPhotoURL)
    }

    fileprivate func setPhoto(with url: URL?) {
        placeImageView.alpha = 0.0
        placeImageView.kf.setImage(with: url, completionHandler: { _, _, _, _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.placeImageView.alpha = 1.0
            })
        })
    }

}
