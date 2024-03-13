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
    @Published var coinDetails: CoinDetails?
    
    private let service: CoinServiceProtocol
    
    init(service: CoinServiceProtocol){
        self.service = service
        Task { await fetchCoins() }
    }

    @MainActor
    func fetchCoins() async {
        do {
            let coins = try await service.fetchCoins()
            self.coins.append(contentsOf: coins)
        } catch {
            if let error = error as? CoinAPIError {
                self.errorMessage = error.customDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func fetchCoinDetails(coinId: String) async {
        do {
            try await Task.sleep(seconds: 0.5)
        } catch {
            self.errorMessage = error.localizedDescription
        }
        do {
            let coinDetails = try await service.fetchCoinDetails(id: coinId)
            self.coinDetails = coinDetails
        } catch {
            if let error = error as? CoinAPIError {
                self.errorMessage = error.customDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

//    func fetchCoinsWithCompletionHandler(){
//        service.fetchCoins { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let coins):
//                    self?.coins = coins
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
