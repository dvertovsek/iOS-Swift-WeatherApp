//
//  LayoutState.swift
//  WeatherApp
//
//  Created by Dare on 18/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

protocol LayoutState {

    var layoutStrategy: LayoutStrategy { get }
    func handleCellSelection(for indexPath: IndexPath)
    func handleScrollViewScrolling(with scrollView: UIScrollView)
    func handleScrollViewDidEndDecelerating(with: UIScrollView)
    func cleanup()

}

extension LayoutState {

    func handleScrollViewScrolling(with scrollView: UIScrollView) {}
    func handleScrollViewDidEndDecelerating(with: UIScrollView) {}
    func cleanup() {}

}
