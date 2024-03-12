//
//  CoinDetailsViewModel.swift
//  SwiftNetworking
//
//  Created by Kari on 3/11/24.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinID: String
    
    @Published var errorMessage: String?
    @Published var coinDetails: CoinDetails?
    
    init(coinID: String) {
        self.coinID = coinID
        
        Task { await fetchCoinDetails() }
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            try await Task.sleep(seconds: 0.5)
        } catch {
            self.errorMessage = error.localizedDescription
        }
        do {
            let coinDetails = try await service.fetchCoinDetails(id: coinID)
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
