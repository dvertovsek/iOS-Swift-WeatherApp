//
//  3x3State.swift
//  WeatherApp
//
//  Created by Dare on 18/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class _3x3State {

    var context: PlacesViewController

    init(context: PlacesViewController) {
        self.context = context
    }

}

extension _3x3State: LayoutState {

    var layoutStrategy: LayoutStrategy {
        return _3x3LayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {
        context.performSegue(withIdentifier: "toWeatherDetailsSegue", sender: nil)
    }

}
