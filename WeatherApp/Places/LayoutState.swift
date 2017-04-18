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
    func handleScrollViewScrolling()
}
