//
//  Coin.swift
//  SwiftNetworking
//
//  Created by Kari on 3/10/24.
//

import Foundation

struct Coin: Codable, Identifiable, Hashable{
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}




