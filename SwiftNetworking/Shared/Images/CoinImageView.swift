//
//  CoinImageView.swift
//  SwiftNetworking
//
//  Created by Kari on 3/12/24.
//

import SwiftUI

struct CoinImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String){
        imageLoader = ImageLoader(url: url)
    }
    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
        }
    }
}
