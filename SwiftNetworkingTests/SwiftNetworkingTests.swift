//
//  SwiftNetworkingTests.swift
//  SwiftNetworkingTests
//
//  Created by Kari on 3/12/24.
//

import XCTest
@testable import SwiftNetworking

final class SwiftNetworkingTests: XCTestCase {
    
    func testDecodeCoinsIntoArray() throws {
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: mockCoinData_default_20)
            XCTAssertTrue(coins.count > 0)
            XCTAssertEqual(coins.count, 20)
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
