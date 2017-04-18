//
//  PageLayoutStrategy.swift
//  WeatherApp
//
//  Created by Dare on 17/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

final class PageLayoutStrategy: LayoutStrategy {

    var layout: UICollectionViewLayout {
        return PageFlowLayout()
    }

}

fileprivate class PageFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        guard let collectionView = collectionView else {
            return
        }
        collectionView.isPagingEnabled = true
    }

    override var itemSize: CGSize {
        set{}
        get {
            guard let collectionView = collectionView else {
                return self.itemSize
            }
            return CGSize(width: collectionView.frame.width,
                          height: collectionView.frame.height)
        }
    }
    
}
