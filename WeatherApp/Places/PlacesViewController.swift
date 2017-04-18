//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dare on 4/15/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import SearchTextField
import Marshal

class PlacesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toggleDisplayModeButton: UIBarButtonItem!

    var layoutStrategy: LayoutStrategy = _3x3LayoutStrategy()

    let dataManager = DataManager()

    var places = [OWMPlace]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = layoutStrategy.layout

        places = dataManager.getMyPlaces()

    }
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a place", message: "Enter place", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "e.g. Zadar"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    func animateLayoutChange() {
        UIView.animate(withDuration: 0.5) {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(self.layoutStrategy.layout, animated: true)
        }
    }

    @IBAction func toggleCollectionLayout() {
        layoutStrategy = _3x3LayoutStrategy()
        animateLayoutChange()
    }

    @IBAction func toggleListLayout() {
        layoutStrategy = ListLayoutStrategy()
        animateLayoutChange()
    }

    @IBAction func togglePageLayout() {
        layoutStrategy = PageLayoutStrategy()
        animateLayoutChange()
    }

}

extension PlacesViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }

}

extension PlacesViewController: UICollectionViewDataSource {

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
            placesCell.placeImageView.image = #imageLiteral(resourceName: "zadar")
            placesCell.placeNameLabel.text = place.name
            placesCell.countryNameLabel.text = place.country
            return placesCell
        }
        return UICollectionViewCell()
    }

}

extension PlacesViewController: UICollectionViewDelegate {
}
