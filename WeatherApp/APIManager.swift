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

    var method: HTTPMethod = .get

    func getWeather(handler: @escaping (_ data: Data?, _ error: Error?) -> Void)
    {
        var url = prepareURL?() ?? ""
        let headers = prepareHeaders?() ?? { return [:] }()
        let parameters = prepareParameters?() ?? { return [:] }()
        if method == .get {
            url += "?"
            parameters.forEach{ url += $0.0+"=\($0.1)&" }
        }
        print("calling: ", url)
        Alamofire.request(
            url,
            method: method,
            parameters: parameters,
            headers: headers).responseData
            { response in

            }
        Alamofire.request(url).responseData { response in
                handler(response.data, response.error)
        }
    }
    
}
