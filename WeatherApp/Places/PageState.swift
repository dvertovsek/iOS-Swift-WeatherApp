//
//  PageLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 21/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class PageState: LayoutState {

    var context: PlacesViewController

    init(context: PlacesViewController) {
        self.context = context
    }

    var layoutStrategy: LayoutStrategy {
        return PageLayoutStrategy()
    }

    func handleCellSelection(for indexPath: IndexPath) {
    }

    func handleScrollViewScrolling(with scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / context.view.frame.width)
        guard scrollView.contentOffset.x >= 0, pageIndex < context.places.count else { return }
        //stopped scrolling
        guard Int(scrollView.contentOffset.x) % Int(context.view.frame.width) == 0 else { return }
        print("zaustavio se na gradu: \(context.places[pageIndex].name)")
    }
}
