//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Léa on 14/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    let secret = Secret()
    let apiKey = secret.apiKey
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func createURL(currency:String) {
        let urlString = baseURL+"/\(currency)"
        fetchData(with: urlString)
    }
    
    func fetchData(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    print(safeData)
                    print(urlResponse)
                    print("got data ! ")
                }
            }
            task.resume()
        }
    }

}
