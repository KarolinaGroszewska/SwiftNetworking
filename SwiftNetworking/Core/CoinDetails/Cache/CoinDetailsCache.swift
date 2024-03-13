//
//  CoinDetailsCache.swift
//  SwiftNetworking
//
//  Created by Kari on 3/11/24.
//

import Foundation

class CoinDetailsCache {
    static let shared = CoinDetailsCache()
    private let cache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func set(_ coinDetails: CoinDetails, forKey key: String) throws {
        do {
            let data = try JSONEncoder().encode(coinDetails)
            cache.setObject(NSData(data: data), forKey: NSString(string: key))
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
    
    func get(forKey key: String) throws -> CoinDetails? {
        guard let data = cache.object(forKey: NSString(string: key)) as? Data else {
            return nil
        }
        do {
            return try JSONDecoder().decode(CoinDetails.self, from: data)
        } catch let error {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
    
}
