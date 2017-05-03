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
//        temperatureLabel.text = 
    }

    @IBAction func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }

}
