//
//  3x3State.swift
//  WeatherApp
//
//  Created by Dare on 18/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class ListState: LayoutState {

    let dataManager = DataManager()

    var context: PlacesViewController

    init(context: PlacesViewController) {
        self.context = context
    }

    var layoutStrategy: LayoutStrategy {
        return ListLayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {
        dataManager.delegate = self

        UIView.animate(withDuration: 0.4, animations: { 
            self.context.bottomInfo.alpha = 0.0
        }) { (_) in
            let place = self.context.places[indexPath.row]
            self.dataManager.getWeather(for: place)
        }
    }

    func handleScrollViewScrolling() {
    }

}

extension ListState: DataManagerResultDelegate {

    func didReturnError(_ error: Error) {
        print("error")
    }

    func didReturnResults(weather: OWMWeather) {
        context.bottomInfo.isHidden = false
        context.degreesLabel.text = "\(weather.data.temp)°"
        context.descriptionLabel.text = weather.description.first!.description
        context.weatherIcon.image = #imageLiteral(resourceName: "owmicon")
        UIView.animate(withDuration: 0.4) { 
            self.context.bottomInfo.alpha = 1.0
        }
    }

}
