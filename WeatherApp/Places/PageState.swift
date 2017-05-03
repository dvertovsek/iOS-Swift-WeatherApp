//
//  PageLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 21/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class PageState {

    var context: PlacesViewController

    var dataManager = DataManager()

    init(context: PlacesViewController) {
        self.context = context

    }

    fileprivate func animateWeatherInfoShown() {
        context.weatherInfoStackView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.context.weatherInfoStackView.frame.origin.y = +self.context.weatherInfoStackView.frame.size.height
            self.context.weatherInfoStackView.alpha = 1.0
        })
    }

    fileprivate func animateWeatherInfoHidden() {
        UIView.animate(withDuration: 0.5, animations: {
            self.context.weatherInfoStackView.frame.origin.y = -self.context.weatherInfoStackView.frame.size.height
            self.context.weatherInfoStackView.alpha = 0.0
        }, completion: { completed in
            if (completed) {
                self.context.weatherInfoStackView.isHidden = true
            }
        })
    }

}

extension PageState: LayoutState {

    var layoutStrategy: LayoutStrategy {
        return PageLayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {
    }

    func handleScrollViewScrolling(with scrollView: UIScrollView) {
        animateWeatherInfoHidden()
        let pageIndex = Int(scrollView.contentOffset.x / context.view.frame.width)
        guard scrollView.contentOffset.x >= 0, pageIndex < context.places.count else { return }
        //stopped scrolling
        guard Int(scrollView.contentOffset.x) % Int(context.view.frame.width) == 0 else { return }
        dataManager.delegate = self
        dataManager.getWeather(for: context.places[pageIndex])
    }
    
}

extension PageState: DataManagerResultDelegate {

    func didReturnResults(weather: OWMWeather) {
        context.temperatureLabel.text = String(format: "%.1f˚C", weather.data.temp)
        context.weatherImageView.image = #imageLiteral(resourceName: "owmicon")
        context.weatherDescriptionLabel.text = weather.description.first?.description
        animateWeatherInfoShown()
    }

    func didReturnError(_ error: Error) {

    }

}
