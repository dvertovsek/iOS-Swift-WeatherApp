//
//  PageLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 21/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class PageState: LayoutState {

    var layoutStrategy: LayoutStrategy {
        return PageLayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {
    }

    func handleScrollViewScrolling() {
    }
    
}
