//
//  CoinsViewModel.swift
//  SwiftNetworking
//
//  Created by Kari on 3/10/24.
//

import Foundation

class CoinsViewModel: ObservableObject {

    @Published var coins = [Coin]()
    @Published var errorMessage: String?
    private let service = CoinDataService()
    
    init(){
        Task { try await fetchCoins() }
    }
    
    func fetchCoins() async throws {
        self.coins = try await service.fetchCoins()
    }
    
    func fetchCoinsWithCompletionHandler(){
        service.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
