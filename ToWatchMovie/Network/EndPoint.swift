//
//  EndPoint.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 05/10/2023.
//

import Foundation

struct Endpoints {
    static let  baseUrl = "https://kinopoiskapiunofficial.tech/api/v2.2/films"
    static let apiKey = "0295f55d-1227-47be-9967-a34f48a17175"
    static let imageId = "1322324"
    static func getPreview(imageId : String) ->
    String {
        let endpoint = "/\(imageId)/images"
        // пробелов не должно быть делать верную интреполяцию
        return baseUrl + endpoint
    }
}


