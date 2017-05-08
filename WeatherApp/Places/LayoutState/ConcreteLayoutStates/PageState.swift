//
//  PageLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 21/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import Kingfisher

class PageState {

    var context: PlacesViewController
    var currentPage = 0

    var dataManager = DataManager()

    init(context: PlacesViewController) {
        self.context = context
        dataManager.delegate = self
    }

    fileprivate func animateWeatherInfoShown() {
        let currentPageWeather = context.places[currentPage].weather!
        context.temperatureLabel.text = String(format: "%.1f˚C", currentPageWeather.data.temp)
        context.weatherImageView.kf.setImage(with: currentPageWeather.description.first?.iconUrl)
        context.weatherDescriptionLabel.text = currentPageWeather.description.first?.description
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
        })
    }

}

extension PageState: LayoutState {

    var layoutStrategy: LayoutStrategy {
        return PageLayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {
        if context.weatherInfoStackView.alpha == 0.0 {
            if context.places[currentPage].weather == nil {
                dataManager.getWeather(for: context.places[currentPage])
            } else {
                animateWeatherInfoShown()
            }
        } else {
            animateWeatherInfoHidden()
        }
    }

    func handleScrollViewScrolling(with scrollView: UIScrollView) {
        animateWeatherInfoHidden()
        let pageIndex = Int(scrollView.contentOffset.x / context.view.frame.width)
        currentPage = pageIndex
        guard scrollView.contentOffset.x >= 0, pageIndex < context.places.count else { return }
        //stopped scrolling
        guard Int(scrollView.contentOffset.x) % Int(context.view.frame.width) == 0 else { return }
        if context.places[currentPage].weather == nil {
            dataManager.getWeather(for: context.places[currentPage])
        } else {
            animateWeatherInfoShown()
        }
    }

    func cleanup() {
        context.weatherInfoStackView.isHidden = true
        animateWeatherInfoHidden()
    }
    
}

extension PageState: DataManagerResultDelegate {

    func didReturnResults(weather: OWMWeather) {
        context.places[currentPage].weather = weather
        animateWeatherInfoShown()
    }

    func didReturnError(_ error: Error) {

    }

}
