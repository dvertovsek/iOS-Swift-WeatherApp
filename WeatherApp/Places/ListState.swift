//
//  3x3State.swift
//  WeatherApp
//
//  Created by Dare on 18/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class ListState: LayoutState {

    var context: PlacesViewController

    init(context: PlacesViewController) {
        self.context = context
    }

    var layoutStrategy: LayoutStrategy {
        return ListLayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {

    }

}
