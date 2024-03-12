//
//  HTTPDataDownloader.swift
//  SwiftNetworking
//
//  Created by Kari on 3/11/24.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Codable>(as type: T.Type, endpoint: String) async throws -> T
}
extension HTTPDataDownloader {
    func fetchData<T: Codable>(as type: T.Type, endpoint: String) async throws -> T{
        guard let url = URL(string: endpoint) else {
            throw CoinAPIError.urlParsingError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(APIKey().key, forHTTPHeaderField: "x-cg-demo-api-key")
        // TODO: work with urlRequest to determine how to add an API key
        //        let urlRequest = URLRequest(url: url)
        //        urlRequest.addValue("API_KEY", forHTTPHeaderField: "x-cg-demo-api-key")
        //        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Bad HTTP Response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let error {
            print("DEBUG: Error \(error.localizedDescription)")
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}
