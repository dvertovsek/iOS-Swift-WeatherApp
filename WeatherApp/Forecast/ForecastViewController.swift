//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Dare on 09/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let dataManager = DataManager()

    var places = [OWMPlace]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = ListLayoutStrategy().layout
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        places = dataManager.myPlaces
        collectionView.reloadData()
    }

}

extension ForecastViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
        -> Int
    {
        return places.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        if
            let placesCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PlacesCollectionViewCell",
                for: indexPath) as? PlacesCollectionViewCell
        {
            let place = places[indexPath.row]
            placesCell.placeImageView.image = #imageLiteral(resourceName: "skyline")
            placesCell.placeNameLabel.text = place.name
            placesCell.countryNameLabel.text = place.country
            return placesCell
        }
        return UICollectionViewCell()
    }

}

extension ForecastViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath)
    {
    }
    
}
