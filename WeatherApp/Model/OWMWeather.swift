//
//  OWMWeather.swift
//  WeatherApp
//
//  Created by Dare on 16/04/2017.
//  Copyright © 2017 Dare. All rights reserved.
//
import Marshal

struct OWMWeather {
    var data: WeatherData
    var description: [WeatherDescription]

    init(with jsonObject: JSONObject) throws {
        data = try jsonObject.value(for: "main")
        description = try jsonObject.value(for: "weather")
    }
}

struct WeatherData: Unmarshaling {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var tempMin: Double
    var tempMax: Double

    init(object: MarshaledObject) throws {
        temp = try object.value(for: "temp")
        pressure = try object.value(for: "pressure")
        humidity = try object.value(for: "humidity")
        tempMin = try object.value(for: "temp_min")
        tempMax = try object.value(for: "temp_max")
    }
}

struct WeatherDescription: Unmarshaling {
    var description: String
    var detailDescription: String
    var iconUrl: URL?

    init(object: MarshaledObject) throws {
        description = try object.value(for: "main")
        detailDescription = try object.value(for: "description")
        let iconUrlString: String = try object.value(for: "icon")
        iconUrl = URL(string: "http://openweathermap.org/img/w/\(iconUrlString).png")
    }
}
