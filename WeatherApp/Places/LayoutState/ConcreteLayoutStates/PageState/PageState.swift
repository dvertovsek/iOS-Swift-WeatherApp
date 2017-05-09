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

    lazy var showWeatherInfoCommand: Command = ShowWeatherInfoCommand(self)
    lazy var hideWeatherInfoCommand: Command = HideWeatherInfoCommand(self)

    init(context: PlacesViewController) {
        self.context = context
        dataManager.weatherDelegate = self
        dataManager.photoDelegate = self
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

        dataManager.getPhoto(for: context.places[currentPage].name)
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

extension PageState: OWMWeatherResultDelegate {

    func didReturnResults(weather: OWMWeather) {
        context.places[currentPage].weather = weather
        setupWeatherInfo()
    }

    func didReturnWeatherError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                      preferredStyle: .alert)
        context.present(alert, animated: true, completion: nil)
    }

}

extension PageState: FlickrPhotoResultDelegate {

    func didReturnPhotoUrl(with url: URL?) {
        setPhoto(with: url)
    }

    func didReturnPhotoError(_ error: Error) {
        setPhoto(with: URL.randomCityPhotoURL)
    }

    fileprivate func setPhoto(with url: URL?) {
        guard
            let visibleCell = context.collectionView.visibleCells.first,
            let placesCell = visibleCell as? PlacesCollectionViewCell
            else { return }
        placesCell.placeImageView.alpha = 0.0
        placesCell.placeImageView.kf.setImage(with: url, completionHandler: { _, _, _, _ in
            UIView.animate(withDuration: 0.5, animations: {
                placesCell.placeImageView.alpha = 1.0
            })
        })
    }

}
