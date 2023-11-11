//
//  NetworkService.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 06/10/2023.
//

import Foundation
import Combine

enum NetworkError : Error {
    case badUrl
    case noData
    case decodingError
}

extension URL {
    static func getPreviewUrl(imageId : String) -> URL? {
        guard let url = URL( string :
                                Endpoints.getPreview(imageId: imageId)) else {
            return nil
        }
        
        return url
        
    }
}
class NetworkService : Error {
    typealias Headers = [String: Any]
    
    
    private init() {}
    
    static func getYandexpreview (imagePreview : String, complition : @escaping (Result<DataForPreview,NetworkError>) -> Void) {
        
        guard let url = URL.getPreviewUrl(imageId: imagePreview )
        else {
            return complition(Result.failure(.badUrl))
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.allHTTPHeaderFields = [ "X-API-KEY": "0295f55d-1227-47be-9967-a34f48a17175"]
        
        
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // я получил свои данные
            
            guard let data = data, error == nil else {
                return complition(.failure(.noData))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                    
                    switch httpResponse.statusCode {
                    case 200...299:
                        // Успешный ответ
                        print("Success!")
                    case 400...499:
                        // Ошибки на стороне клиента
                        print("Client error!")
                    case 500...599:
                        // Ошибки на стороне сервера
                        print("Server error!")
                    default:
                        print("Unknown status code!")
                    }
                }
            
            do {
                // use try before function where rather just could be failed$
                             
                let previewResponse = try JSONDecoder().decode(DataForPreview.self, from: data)
                complition(.success( previewResponse))
            } catch(let error) {
                print(error)
                return complition(.failure(.decodingError))
                
            }
            
        }.resume()
        
        
    }
    
    static func  getImage (
        url: URL,
        headers: Headers
    ) -> AnyPublisher<Data, URLError> {
//        if let cachedImageData = ImageCache.shared.getImageData(for: url) {
//            return Just(cachedImageData)
//                .setFailureType(to: URLError.self)
//                .eraseToAnyPublisher()
//        }
//
        var urlRequest = URLRequest(url: url)
        
        urlRequest.allHTTPHeaderFields = [:]
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .handleEvents(receiveOutput: { response in
//                let data = response.data
//                ImageCache.shared.setImageData(data, for: url)
                
                //                print("Response: \(response)")
                //                let utf8Text = String(data: response.data, encoding: .utf8)
                //                print(utf8Text)
            })
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
