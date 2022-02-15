//
//  ConverterViewController.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import UIKit

protocol ConverterViewControllerDelegate {
    func updateValueFromCurrency(for currencyInfo: CurrencyInfo)
}

protocol ConverterViewControllerAnotherDelegate {
    func updateValuetoCurrency(for currencyInfo: CurrencyInfo)
}

class ConverterViewController: UIViewController, UITextFieldDelegate {
    
    private var currencyNameFrom: String = "USD" {
        didSet {
            updateRate(from: currencyNameFrom, to: currencyNameTo)
        }
    }
    
    private var currencyNameTo: String = "BYN" {
        didSet {
            updateRate(from: currencyNameFrom, to: currencyNameTo)
        }
    }
    
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.placeholder = "summ"
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .valueChanged)
        return textField
    }()
    
    private lazy var resultTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.keyboardType = .decimalPad
        textField.placeholder = "summ"
        textField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .valueChanged)
        return textField
    }()
    
    private let fromButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "USD"), for: .normal)
        button.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    private let toButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "BYN"), for: .normal)
        button.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "arrow")
        return image
    }()
    
    private let currencyCodeLabelFrom: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "840"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let currencyCodeLabelTo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "978"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let currencyRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        view.backgroundColor = .systemGray6
        
        setupSubviews(resultTextField, amountTextField, fromButton, toButton, arrowImage, currencyCodeLabelTo, currencyCodeLabelFrom, currencyRateLabel)
        
        setupAmountTFConstraints()
        setupResultLabelConstraints()
        setupArrowImageConstraints()
        setupFromButtonConstraints()
        setupToButtonConstraints()
        setupFromLabelConstraints()
        setupToLabelConstraints()
        setuoRateLabelConstraints()
        
        updateRate(from: currencyNameFrom, to: currencyNameTo)
        amountTextField.delegate = self
        resultTextField.delegate = self
    }
    
    @objc private func selectCurrency(_ button: UIButton) {
        let currencyListVC = CurrencyListViewController()
        
        if button.tag == 0 {
            currencyListVC.delegateFrom = self
        } else {
            currencyListVC.delegateTo = self
        }
        present(currencyListVC, animated: true)
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Currency Converter"
    }
    
    private func updateRate(from: String, to: String) {
        NetworkManager.shared.fetchCurrencyInfo(from: from, to: to) { [weak self] result in
            switch result {
            case .success(let convert):
                if let date = convert.date, let rate = convert.info?.rate  {
                    self?.currencyRateLabel.text = "\(date) - \(rate)"
                    self?.amountTextField.text = ""
                    self?.resultTextField.text = ""
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchData(from: String, to: String, amount: String?, completion: @escaping()-> Void) {
        
        if amountTextField.isFirstResponder {
            NetworkManager.shared.fetchCurrencyInfo(from: from, to: to, amount: amount) { [weak self] result in
                switch result {
                case .success(let convert):
                    self?.resultTextField.text = String(format: "%.2f", convert.result ?? "")
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            NetworkManager.shared.fetchCurrencyInfo(from: from, to: to, amount: amount) { [weak self] result in
                switch result {
                case .success(let convert):
                    self?.amountTextField.text = String(format: "%.2f", convert.result ?? "")
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: -  UITextViewDelegate
extension ConverterViewController {
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == amountTextField {
            fetchData(from: currencyNameFrom, to: currencyNameTo, amount: textField.text) { [ weak self ] in
                if textField.text == "" {
                    self?.resultTextField.text = ""
                }
            }
        } else {
            fetchData(from: currencyNameTo, to: currencyNameFrom, amount: textField.text) { [ weak self ] in
                if textField.text == "" {
                    self?.amountTextField.text = ""
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - ConverterViewControllerDelegate
extension ConverterViewController: ConverterViewControllerDelegate, ConverterViewControllerAnotherDelegate {
    func updateValueFromCurrency(for currencyInfo: CurrencyInfo) {
        currencyCodeLabelFrom.text = currencyInfo.currencyCode
        fromButton.setImage(UIImage(named: currencyInfo.image), for: .normal)
        currencyNameFrom = currencyInfo.name
    }
    
    func updateValuetoCurrency(for currencyInfo: CurrencyInfo) {
        currencyCodeLabelTo.text = currencyInfo.currencyCode
        toButton.setImage(UIImage(named: currencyInfo.image), for: .normal)
        currencyNameTo = currencyInfo.name
    }
}

// MARK: - Setup UI Constraints
extension ConverterViewController {
    private func setuoRateLabelConstraints() {
        NSLayoutConstraint.activate([
            currencyRateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            currencyRateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    private func setupArrowImageConstraints() {
        NSLayoutConstraint.activate([
            arrowImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            arrowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupFromButtonConstraints() {
        NSLayoutConstraint.activate([
            fromButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            fromButton.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -5)
        ])
    }
    
    private func setupFromLabelConstraints() {
        NSLayoutConstraint.activate([
            currencyCodeLabelFrom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            currencyCodeLabelFrom.trailingAnchor.constraint(equalTo: fromButton.leadingAnchor, constant: -5)
        ])
    }
    
    private func setupToButtonConstraints() {
        NSLayoutConstraint.activate([
            toButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            toButton.leadingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupToLabelConstraints() {
        NSLayoutConstraint.activate([
            currencyCodeLabelTo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            currencyCodeLabelTo.leadingAnchor.constraint(equalTo: toButton.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupAmountTFConstraints() {
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: fromButton.bottomAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -140),
            amountTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
        ])
    }
    
    private func setupResultLabelConstraints() {
        NSLayoutConstraint.activate([
            resultTextField.topAnchor.constraint(equalTo: toButton.bottomAnchor, constant: 20),
            resultTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            resultTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 140),
        ])
    }
}
