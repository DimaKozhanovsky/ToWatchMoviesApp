
//  ImageCache.swift
//  PrivacyShieldDataSafe
//
//  Created by Dmitry Lipuntsov on 30.09.2023.
//

import Foundation

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, NSData>()
    
    private init() {}
    
    func getImageData(for url: URL) -> Data? {
        if let cachedImageData = cache.object(forKey: url as NSURL) as Data? {
            return cachedImageData
        }
        return nil
    }
    
    func setImageData(_ data: Data, for url: URL) {
        cache.setObject(data as NSData, forKey: url as NSURL)
    }
}
