//
//  CoinDetails.swift
//  SwiftNetworking
//
//  Created by Kari on 3/11/24.
//

import Foundation

struct CoinDetails: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
}

// TODO: Add localizations
struct Description: Codable{
    let text: String
    let frenchText: String
    enum CodingKeys: String, CodingKey {
        case text = "en"
        case frenchText = "fr"
    }
}



