//
//  FlickrPhoto.swift
//  WeatherApp
//
//  Created by Dare on 08/05/2017.
//  Copyright © 2017 Dare. All rights reserved.
//

import Marshal

struct FlickrData {

    let meta: Meta

    init(with jsonObject: JSONObject) throws {
        meta = try jsonObject.value(for: "photos")
    }
}

struct Meta: Unmarshaling {
    let photosArray: [FlickrPhoto]

    init(object: MarshaledObject) throws {
        photosArray = try object.value(for: "photo")
    }
}

struct FlickrPhoto: Unmarshaling {
    let photoURL: URL?

    fileprivate let farm: Int
    fileprivate let server: String
    fileprivate let id: String
    fileprivate let secret: String

    init(object: MarshaledObject) throws {
        server = try object.value(for: "server")
        id = try object.value(for: "id")
        secret = try object.value(for: "secret")
        farm = try object.value(for: "farm")
        photoURL = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")
    }
}


