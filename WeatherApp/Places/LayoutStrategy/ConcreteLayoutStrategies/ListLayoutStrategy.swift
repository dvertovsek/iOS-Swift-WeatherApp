//
//  ListLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 16/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class ListLayoutStrategy: LayoutStrategy {

    var layout: UICollectionViewLayout {
        return ListFlowLayout()
    }

}

fileprivate class ListFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        guard let collectionView = collectionView else {
            return
        }
        collectionView.isPagingEnabled = false
    }

    override var itemSize: CGSize {
        set{}
        get {
            guard let collectionView = collectionView else {
                return self.itemSize
            }
            let itemWidth = collectionView.frame.width
            let itemHeight = collectionView.frame.height / 5
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
}
