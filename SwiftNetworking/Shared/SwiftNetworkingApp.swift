//
//  SwiftNetworkingApp.swift
//  SwiftNetworking
//
//  Created by Kari on 3/10/24.
//

import SwiftUI

@main
struct SwiftNetworkingApp: App {
    @StateObject var viewModel = CoinsViewModel(service: CoinDataService())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
