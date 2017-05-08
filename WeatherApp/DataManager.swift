//
//  JSONManager.swift
//  WeatherApp
//
//  Created by Dare on 16/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import Marshal

protocol DataManagerResultDelegate {
    func didReturnError(_ error: Error)
    func didReturnResults(weather: OWMWeather)
}

class DataManager {

    let apiManager = APIManager()
    var delegate: DataManagerResultDelegate?

    private static var _myPlaces: [OWMPlace]?

    func getWeather(for place: OWMPlace)
    {
        apiManager.prepareURL = { return "http://api.openweathermap.org/data/2.5/weather?appid=\(Constants.OWMAPIKey)&id=\(place.id)&units=metric" }
        apiManager.getWeather() { data, error in
            if let error = error {
                self.delegate?.didReturnError(error)
            } else if
                let data = data
            {
                do{
                    let json = try JSONParser.JSONObjectWithData(data)
                    let weather: OWMWeather = try OWMWeather(with: json)
                    self.delegate?.didReturnResults(weather: weather)
                }catch{}
            }
        }
    }

    func addMyPlace(place: OWMPlace) {
        var newPlaces = [place]
        if let _myPlaces = DataManager._myPlaces {
            newPlaces.append(contentsOf: _myPlaces)
        }
        DataManager._myPlaces = newPlaces
        saveMyPlaceToStorage(with: place.id)
    }

    var myPlaces: [OWMPlace] {
        guard let _myPlaces = DataManager._myPlaces else {
            DataManager._myPlaces = getMyPlacesFromStorage()
            return DataManager._myPlaces!
        }
        return _myPlaces
    }

    var allPlaces: [OWMPlace] {
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)

                let json = try JSONParser.JSONObjectWithData(data)
                return try json.value(for: "citiesArray")
            } catch {
                print("Error parsing jSON: \(error)")
            }
        }
        return [OWMPlace]()
    }

    private func getMyPlacesFromStorage() -> [OWMPlace] {
        guard
            let placeNames = UserDefaults.standard.object(forKey: Constants.placesIDs) as? [Int]
        else {
            return [OWMPlace]()
        }
        return placeNames.map({ id in
            allPlaces.first{ $0.id == id }!
        })
    }

    private func saveMyPlaceToStorage(with Id: Int) {
        var newPlaceNames = [Id]
        if
            let placeNamesFromStorage = UserDefaults.standard.object(forKey: Constants.placesIDs) as? [Int]
        {
            newPlaceNames.append(contentsOf: placeNamesFromStorage)
        }
        UserDefaults.standard.set(newPlaceNames, forKey: Constants.placesIDs)
    }

}
