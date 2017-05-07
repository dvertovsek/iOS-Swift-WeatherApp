//
//  AddPlaceViewController.swift
//  WeatherApp
//
//  Created by Dare on 07/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import SearchTextField

class AddPlaceViewController: UIViewController {

    @IBOutlet weak var myPlaceSearchTextField: SearchTextField!

    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let places = dataManager.allPlaces
        myPlaceSearchTextField.filterStrings(places.map{ $0.name })
    }

    @IBAction func addMyPlace() {
        guard
            let place = dataManager.allPlaces.filter({ $0.name == myPlaceSearchTextField.text }).first
        else { return }
        dataManager.addMyPlace(place: place)
        dismiss(animated: true, completion: nil)
    }

}
