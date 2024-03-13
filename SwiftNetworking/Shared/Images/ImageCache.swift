//
//  ImageCache.swift
//  SwiftNetworking
//
//  Created by Kari on 3/12/24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    func set(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
