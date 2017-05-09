//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Dare on 03/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!

    @IBOutlet weak var weatherDetailDescriptionLabel: UILabel!

    var place: OWMPlace?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWeatherLabels()
    }

    func setupWeatherLabels() {
        guard let place = place else { return }
        temperatureLabel.text = "\(place.weather?.data.temp ?? 0.0)"
        weatherImageView.kf.setImage(with: place.weather?.description.first?.iconUrl)
        weatherDescriptionLabel.text = place.weather?.description.first?.description
        weatherDetailDescriptionLabel.text = place.weather?.description.first?.detailDescription
    }

    @IBAction func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }

}
