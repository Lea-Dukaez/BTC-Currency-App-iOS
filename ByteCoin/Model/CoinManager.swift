//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Léa on 14/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCurrency(currencyRate: String)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let secret = Secret()
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func performRequest(currency:String) {
        let apiKey = secret.apiKey
        let urlString = baseURL+"/\(currency)"+"?apikey=\(apiKey)"
        fetchData(with: urlString)
    }
    
    func fetchData(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async {
                        if let currencyValue = self.ReadJSONData(data: safeData) {
                            self.delegate?.didUpdateCurrency(currencyRate: currencyValue)
                        }
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func ReadJSONData(data: Data) -> String? {
        do {
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode(CoinData.self, from: data)
            let rate = String(format: "%.2f", decodedData.rate)
            return rate
        } catch {
            print("JSON Serialization error")
            return nil
        }
    }

}


