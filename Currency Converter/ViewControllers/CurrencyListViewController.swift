//
//  CurrencyListViewController.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import UIKit

class CurrencyListViewController: UITableViewController {
    
    var delegateFrom: ConverterViewControllerDelegate?
    var delegateTo: ConverterViewControllerAnotherDelegate?
    
    private let currencyInfo: [CurrencyInfo] = DataManager.shared.currencies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.cell.rawValue)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.cell.rawValue, for: indexPath)
        
        let currency = currencyInfo[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(named: currency.image)
        content.text = currency.name
        content.secondaryText = currency.currencyCode
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currency = currencyInfo[indexPath.row]
        delegateFrom?.updateValueFromCurrency(for: currency)
        delegateTo?.updateValuetoCurrency(for: currency)
        dismiss(animated: true)
    }
}
