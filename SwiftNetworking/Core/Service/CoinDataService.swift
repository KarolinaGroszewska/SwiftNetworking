//
//  CoinDataService.swift
//  SwiftNetworking
//
//  Created by Kari on 3/10/24.
//

import Foundation

struct CoinDataService: HTTPDataDownloader {
    
    func fetchCoins() async throws -> [Coin]{
        guard let endpoint = allCoinsURLString else {
            throw CoinAPIError.requestFailed(description: "Invalid endpoint")
        }
        return try await fetchData(as: [Coin].self, endpoint: endpoint)
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails?{
        guard let endpoint =  coinDetailsURLString(id: id) else {
            throw CoinAPIError.requestFailed(description: "Invalid endpoint")
        }
        return try await fetchData(as: CoinDetails.self, endpoint: endpoint)
    }

    
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        return components
    }
    
    private var allCoinsURLString: String? {
        var components = baseURLComponents
        components.path += "markets"
        components.queryItems = [
            //TODO: Use enums to add some localization and currency locales
            .init(name: "vs_currency", value: "usd"),
            .init(name: "per_page", value: "25"),
            .init(name: "locale", value: "en")
        ]
        return components.url?.absoluteString
    }
    
    private func coinDetailsURLString(id: String) -> String? {
        var components = baseURLComponents
        components.path += "\(id)"
        return components.url?.absoluteString
    }

}

// MARK: Completion Handler
//extension CoinDataService {
//    func fetchCoins(completionHandler: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
//        guard let url = URL(string: coinsURLString) else {
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completionHandler(.failure(.unknownError(error: error)))
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completionHandler(.failure(.requestFailed(description: "Bad HTTP Response")))
//                return
//            }
//            guard httpResponse.statusCode == 200 else {
//                completionHandler(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
//                return
//            }
//            guard let data = data else {
//                completionHandler(.failure(.invalidData))
//                return
//            }
//            do {
//                let coins = try JSONDecoder().decode([Coin].self, from: data)
//                completionHandler(.success(coins))
//            } catch{
//                print("DEBUG: Failed to decode JSON object with error \(error)")
//                completionHandler(.failure(.jsonParsingFailure))
//            }
//        }.resume()
//    }
//
//    func fetchPrice(coin: String, completionHandler: @escaping(Double) -> Void){
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd") else { return }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("DEBUG: Failed with error \(error.localizedDescription)")
//                //                    self.errorMessage = error.localizedDescription
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                //                    self.errorMessage = "Bad HTTP response"
//                return
//            }
//            guard httpResponse.statusCode == 200 else {
//                //                    self.errorMessage = "Failed to fetch request with status code \(httpResponse.statusCode)"
//                return
//            }
//            guard let data = data else {
//                print("Failed to retrieve data from the API")
//                return
//            }
//            let jsonObject : Any?
//            do {
//                jsonObject = try JSONSerialization.jsonObject(with: data)
//            } catch let error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let objectDict = jsonObject as? [String: Any] else {
//                print("Failed to convert JSON object to a dictionary")
//                return
//            }
//            guard let value = objectDict["\(coin)"] as? [String:Int] else {
//                print("Failed to convert JSON for coin value to a dictionary")
//                return
//            }
//            guard let price = value["usd"] else {
//                print("Failed to convert coin value from a dictionary")
//                return
//            }
//            completionHandler(Double(price))
//        }.resume()
//        
//    }
//}
