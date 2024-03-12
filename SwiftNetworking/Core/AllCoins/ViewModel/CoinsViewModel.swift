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
        Task {
            await fetchCoins()
        }
    }
    
    // NOTE: this is not a throwing function – if something goes wrong, all we need is the `catch` block
    @MainActor
    func fetchCoins() async {
        do {
            self.coins = try await service.fetchCoins()
        } catch {
            if let error = error as? CoinAPIError {
                self.errorMessage = error.customDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
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
}
