//
//  CoinDataService.swift
//  SwiftNetworking
//
//  Created by Kari on 3/10/24.
//

import Foundation

struct CoinDataService: HTTPDataDownloader {
    private var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.
    }
    func fetchCoins() async throws -> [Coin]{
        let coinsURLString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=25&locale=en"
        return try await fetchData(as: [Coin].self, endpoint: coinsURLString)
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails?{
        let coinDetailsURLString = "https://api.coingecko.com/api/v3/coins/\(id)"
        return try await fetchData(as: CoinDetails.self, endpoint: coinDetailsURLString)
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
