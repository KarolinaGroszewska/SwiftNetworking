//
//  ContentView.swift
//  SwiftNetworking
//
//  Created by Kari on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: CoinsViewModel
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin){
                        HStack(spacing: 12){
                            Text("\(coin.marketCapRank)")
                                .foregroundColor(.gray)
                            CoinImageView(url: coin.image)
                                .frame(width: 32, height: 32)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.semibold)
                                Text(coin.symbol.uppercased())
                            }
                        }
                        .onAppear {
                            if coin == viewModel.coins.last {
                                Task { await viewModel.fetchCoins() }
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinDetailsView(coin: coin)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}
