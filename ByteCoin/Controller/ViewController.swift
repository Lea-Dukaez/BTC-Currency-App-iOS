//
//  ViewController.swift
//  ByteCoin
//
//  Created by Léa on 12/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}


// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

// MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyChosen = coinManager.currencyArray[row]
        currencyName.text = currencyChosen
        coinManager.performRequest(currency: currencyChosen)
    }
}

extension ViewController: CoinManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCurrency(currencyRate: String) {
        value.text = currencyRate
    }
}
