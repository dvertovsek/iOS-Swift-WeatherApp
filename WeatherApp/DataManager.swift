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

    func getWeather(for place: OWMPlace) {
        apiManager.getWeather(for: place) { data, error in
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

    func getMyPlaces() -> [OWMPlace] {
        let allPlaces = getAllPlaces()
        var places = [OWMPlace]()
        places.append(allPlaces[allPlaces.index{ $0.name == "Zadar" } ?? 0])
        return places + allPlaces[0...30]
    }

    func getAllPlaces() -> [OWMPlace] {
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

}
