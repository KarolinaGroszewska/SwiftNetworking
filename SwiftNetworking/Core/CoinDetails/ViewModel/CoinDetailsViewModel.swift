//
//  CoinDetailsViewModel.swift
//  SwiftNetworking
//
//  Created by Kari on 3/11/24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service: CoinDataService
    private let coinID: String
    
    @Published var errorMessage: String?
    @Published var coinDetails: CoinDetails?
    
    init(service: CoinDataService, coinID: String) {
        self.service = service
        self.coinID = coinID
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            self.coinDetails = try await service.fetchCoinDetails(id: coinID)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
