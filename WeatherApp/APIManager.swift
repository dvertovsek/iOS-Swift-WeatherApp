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
    var getUnits: (() -> String)?

    static var getAPIKey = { return Constants.APIKeys.OWM }

    var method: HTTPMethod?

    func getWeather(handler: @escaping (_ data: Data?, _ error: Error?) -> Void)
    {
        let url = prepareURL?() ?? ""
        let headers = prepareHeaders?() ?? { return [:] }()
        var parameters = prepareParameters?() ?? { return [:] }()
        parameters["appid"] = APIManager.getAPIKey()
        parameters["units"] = getUnits?() ?? { return "metric" }
        Alamofire.request(
            url,
            method: method ?? .get,
            parameters: parameters,
            headers: headers).responseData
            { response in

            }
        Alamofire.request(url).responseData { response in
                handler(response.data, response.error)
        }
    }
    
}
