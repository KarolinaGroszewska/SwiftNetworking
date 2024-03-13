//
//  MockCoinService.swift
//  SwiftNetworking
//
//  Created by Kari on 3/12/24.
//

import Foundation
@testable import SwiftNetworking

class MockCoinService: CoinServiceProtocol {
    
    var mockData: Data?
    var mockError: CoinAPIError?
    
    func fetchCoins() async throws -> [Coin] {
        if let mockError { throw mockError }
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockData ?? mockCoinData_default_20)
            return coins
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
    func fetchCoinDetails(id: String) async throws -> CoinDetails? {
        let description = Description(text: "Text Description")
        let bitcoinDetails = CoinDetails(id: "bitcoin", symbol: "btc", name: "Bitcoin", description: description)
        return bitcoinDetails
    }
}
