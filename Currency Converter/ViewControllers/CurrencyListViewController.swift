//
//  CurrencyListViewController.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import UIKit

class CurrencyListViewController: UITableViewController {
    
    var currency: Currency?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.cell.rawValue)
        navigationItem.largeTitleDisplayMode = .never
//       fetchData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.cell.rawValue, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        if indexPath.row == 0 {
            content.image = UIImage(named: "USD")
            content.text = "USD"
            content.secondaryText = "Код валюты: 840"
        } else if indexPath.row == 1 {
            content.image = UIImage(named: "EUR")
            content.text = "EUR"
            content.secondaryText = "Код валюты: 978"
        } else if indexPath.row == 2 {
            content.image = UIImage(named: "BYN")
            content.text = "BYN"
            content.secondaryText = "Код валюты: 643"
        } else if indexPath.row == 3 {
            content.image = UIImage(named: "RUB")
            content.text = "RUB"
            content.secondaryText = "Код валюты: 933"
        }
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    private func fetchData() {
//        NetworkManager.shared.fetchCurrencies { [weak self] result in
//            switch result {
//            case .success(let currencies):
//                self?.currency = currencies?.response.fiats
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
