//
//  APIManager.swift
//  WeatherApp
//
//  Created by Dare on 4/15/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import Alamofire
import Marshal

class APIManager {

    var prepareURL: (() -> String)?
    var prepareHeaders: (() -> [String: String])?
    var prepareParameters:  (() -> [String: Any])?

    var method: HTTPMethod?

    //{"coord":{"lon":145.77,"lat":-16.92},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"base":"stations","main":{"temp":300.15,"pressure":1007,"humidity":74,"temp_min":300.15,"temp_max":300.15},"visibility":10000,"wind":{"speed":3.6,"deg":160},"clouds":{"all":40},"dt":1485790200,"sys":{"type":1,"id":8166,"message":0.2064,"country":"AU","sunrise":1485720272,"sunset":1485766550},"id":2172797,"name":"Cairns","cod":200}
    func getWeather(for place: OWMPlace,
                    handler: @escaping (_ data: Data?, _ error: Error?) -> Void)
    {
        let url = prepareURL?() ?? ""
        let headers = prepareHeaders?() ?? { return [:] }()
        let parameters = prepareParameters?() ?? { return [:] }()
        Alamofire.request(
            url,
            method: method ?? .get,
            parameters: parameters,
            headers: headers).responseData
            { response in

            }
        Alamofire.request(
            "http://api.openweathermap.org/data/2.5/weather?id=\(place.id)&appid=ac5153fcd4854aab008bc02dc35f139f&units=metric").responseData { response in
                // mozda i ovo napraviti templateicno
                handler(response.data, response.error)
        }
    }
    
}
