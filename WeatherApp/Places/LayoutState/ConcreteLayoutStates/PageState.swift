//
//  PageLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 21/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import Kingfisher

protocol Command {
    func execute()
}

class HideWeatherInfoCommand: Command {

    let pageState: PageState

    init(_ pageState: PageState) {
        self.pageState = pageState
    }

    func execute() {
        UIView.animate(withDuration: 0.5, animations: {
            self.pageState.context.weatherInfoStackView.frame.origin.y = -self.pageState.context.weatherInfoStackView.frame.size.height
            self.pageState.context.weatherInfoStackView.alpha = 0.0
        })
    }

}

class ShowWeatherInfoCommand: Command {
    let pageState: PageState

    init(_ pageState: PageState) {
        self.pageState = pageState
    }

    func execute() {
        UIView.animate(withDuration: 0.5, animations: {
            self.pageState.context.weatherInfoStackView.frame.origin.y = +self.pageState.context.weatherInfoStackView.frame.size.height
            self.pageState.context.weatherInfoStackView.alpha = 1.0
        })
    }
}

class PageState {

    var context: PlacesViewController
    var currentPage = 0

    var dataManager = DataManager()

    lazy var showWeatherInfoCommand: Command = ShowWeatherInfoCommand(self)
    lazy var hideWeatherInfoCommand: Command = HideWeatherInfoCommand(self)

    init(context: PlacesViewController) {
        self.context = context
        dataManager.delegate = self
    }

    fileprivate func setupWeatherInfo() {
        let currentPageWeather = context.places[currentPage].weather!
        context.temperatureLabel.text = String(format: "%.1f˚C", currentPageWeather.data.temp)
        context.weatherImageView.kf.setImage(with: currentPageWeather.description.first?.iconUrl)
        context.weatherDescriptionLabel.text = currentPageWeather.description.first?.description
        context.weatherInfoStackView.isHidden = false
        showWeatherInfoCommand.execute()
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
                setupWeatherInfo()
            }
        } else {
            hideWeatherInfoCommand.execute()
        }
    }

    func handleScrollViewScrolling(with scrollView: UIScrollView) {
        hideWeatherInfoCommand.execute()
        let pageIndex = Int(scrollView.contentOffset.x / context.view.frame.width)
        currentPage = pageIndex
    }

    func handleScrollViewDidEndDecelerating(with: UIScrollView) {
        if context.places[currentPage].weather == nil {
            dataManager.getWeather(for: context.places[currentPage])
        } else {
            setupWeatherInfo()
        }
    }

    func cleanup() {
        context.weatherInfoStackView.isHidden = true
        hideWeatherInfoCommand.execute()
    }
    
}

extension PageState: DataManagerResultDelegate {

    func didReturnResults(weather: OWMWeather) {
        context.places[currentPage].weather = weather
        setupWeatherInfo()
    }

    func didReturnError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                      preferredStyle: .alert)
        context.present(alert, animated: true, completion: nil)
    }

}
