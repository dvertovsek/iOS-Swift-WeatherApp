//
//  JSONManager.swift
//  WeatherApp
//
//  Created by Dare on 16/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import Marshal

protocol OWMWeatherResultDelegate {
    func didReturnResults(weather: OWMWeather)
    func didReturnWeatherError(_ error: Error)
}

protocol FlickrPhotoResultDelegate {
    func didReturnPhotoUrl(with url: URL?)
    func didReturnPhotoError(_ error: Error)
}

class DataManager {

    let apiManager = APIManager()
    var weatherDelegate: OWMWeatherResultDelegate?
    var photoDelegate: FlickrPhotoResultDelegate?

    private static var _myPlaces: [OWMPlace]?

    func getWeather(for place: OWMPlace)
    {
        apiManager.prepareURL = { return "http://api.openweathermap.org/data/2.5/weather" }
        apiManager.prepareParameters = {
            return [
                "appid": Constants.APIKeys.OWM,
                "id": place.id,
                "units": "metric"
            ]
        }
        apiManager.getWeather() { data, error in
            if let error = error {
                self.weatherDelegate?.didReturnWeatherError(error)
            } else if
                let data = data
            {
                do{
                    let json = try JSONParser.JSONObjectWithData(data)
                    let weather: OWMWeather = try OWMWeather(with: json)
                    self.weatherDelegate?.didReturnResults(weather: weather)
                }catch{}
            }
        }
    }

    func getPhoto(for searchText: String) {
        apiManager.prepareURL = { return "https://api.flickr.com/services/rest/" }
        apiManager.prepareParameters = {
            return [
                "method": "flickr.photos.search",
                "api_key": Constants.APIKeys.Flickr,
                "format": "json",
                "nojsoncallback": 1,
                "per_page": 1,
                "text": searchText,
                "media": "photos",
                "content-type": 1,
                "tags": "city"
            ]
        }
        apiManager.getWeather { (data, error) in
            if let error = error {
                self.photoDelegate?.didReturnPhotoError(error)
            }
            do{
                guard let data = data else { return }
                let json = try JSONParser.JSONObjectWithData(data)
                let flickrData = try FlickrData(with: json)
                self.photoDelegate?.didReturnPhotoUrl(with: flickrData.meta.photosArray.first?.photoURL)
            } catch{}
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
