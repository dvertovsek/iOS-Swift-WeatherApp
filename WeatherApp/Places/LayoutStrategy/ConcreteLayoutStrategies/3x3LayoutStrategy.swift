//
//  3x3LayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 16/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

final class _3x3LayoutStrategy: LayoutStrategy {

    var layout: UICollectionViewLayout
    {
        return _3x3FlowLayout()
    }

}

fileprivate class _3x3FlowLayout: UICollectionViewFlowLayout {

    let numberOfItemsInRow: CGFloat = 3

    override func prepareForTransition(from oldLayout: UICollectionViewLayout) {
        scrollDirection = .vertical
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        guard let collectionView = collectionView else {
            return
        }
        collectionView.isPagingEnabled = false
    }

    override var itemSize: CGSize {
        set{ }
        get {
            guard let collectionView = collectionView else {
                return self.itemSize
            }
            let numberOfSpaces = numberOfItemsInRow - 1
            let spacesSize = numberOfSpaces * minimumInteritemSpacing
            let itemWidth = (collectionView.frame.width - spacesSize) / numberOfItemsInRow
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
}

