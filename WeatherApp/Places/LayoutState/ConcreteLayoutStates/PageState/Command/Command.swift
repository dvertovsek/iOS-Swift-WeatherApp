//
//  Command.swift
//  WeatherApp
//
//  Created by Dare on 08/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

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

