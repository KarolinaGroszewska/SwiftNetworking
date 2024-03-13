//
//  CoinDetailsView.swift
//  SwiftNetworking
//
//  Created by Kari on 3/11/24.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    @EnvironmentObject var viewModel: CoinsViewModel
    
    init(coin: Coin){
        self.coin = coin
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                if let details = viewModel.coinDetails {
                    Text(details.name)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    Text(details.id.uppercased())
                        .font(.footnote)
                    //TODO: Parse Links from JSON so they actually display
                    Text(details.description.text)
                        .font(.footnote)
                }
                
            }
        }
        .padding()
        .task {
            await viewModel.fetchCoinDetails(coinId: coin.id)
        }
    }
}

