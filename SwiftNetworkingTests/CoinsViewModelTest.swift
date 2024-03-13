//
//  CoinsViewModelTest.swift
//  SwiftNetworkingTests
//
//  Created by Kari on 3/12/24.
//

import XCTest
@testable import SwiftNetworking

final class CoinsViewModelTest: XCTestCase {
    
    func testInit(){
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service:service)
        
        XCTAssertNotNil(viewModel, "The view model should not be nil")
    }
    
    func testSuccessfulCoinsFetch() async {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        XCTAssert(viewModel.coins.count > 0)
        XCTAssert(viewModel.coins.count == 20)
        XCTAssert(viewModel.coins == viewModel.coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
    }
    
    func testCoinFetchWithInvalidJSON() async {
        let service = MockCoinService()
        service.mockData = mockCoinData_invalidJSON
        
        let viewModel = CoinsViewModel(service: service)
        await viewModel.fetchCoins()
        XCTAssert(viewModel.coins.isEmpty)
        XCTAssert(viewModel.errorMessage != nil)
    }

}
