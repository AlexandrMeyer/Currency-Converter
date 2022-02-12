//
//  ConverterViewController.swift
//  Currency Converter
//
//  Created by Александр on 11/02/2022.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var currencies: Currencies?
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.placeholder = "amount"

        return textField
    }()
    
    private let resultTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.placeholder = "result"
        return textField
    }()
    
    private let fromButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "USD"), for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(selectCurrency), for: .touchUpInside)
        return button
    }()
    
    private let toButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "EUR"), for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(selectCurrency), for: .touchUpInside)
        return button
    }()
    
    private let currencyCodeLabelFrom: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "840"
        label.font = .systemFont(ofSize: 20)
        label.layer.frame.size.height = 50
        return label
    }()
    
    private let currencyCodeLabelTo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "933"
        label.font = .systemFont(ofSize: 20)
        label.layer.frame.size.height = 50
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "arrow")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        setupSubviews(resultTextField, amountTextField, fromButton, toButton, arrowImage, currencyCodeLabelTo, currencyCodeLabelFrom)
        
        setupAmountTFConstraints()
        setupResultLabelConstraints()
        setupArrowImageConstraints()
        setupFromButtonConstraints()
        setupToButtonConstraints()
        setupFromLabelConstraints()
        setupToLabelConstraints()
    }
    
    @objc private func selectCurrency() {
        let currencyListVC = CurrencyListViewController()
        navigationController?.pushViewController(currencyListVC, animated: true)
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
    
    private func setupArrowImageConstraints() {
        NSLayoutConstraint.activate([
            arrowImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            arrowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupFromButtonConstraints() {
        NSLayoutConstraint.activate([
            fromButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            fromButton.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: 0)
        ])
    }
    
    private func setupFromLabelConstraints() {
        NSLayoutConstraint.activate([
            currencyCodeLabelFrom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            currencyCodeLabelFrom.trailingAnchor.constraint(equalTo: fromButton.leadingAnchor, constant: 0)
        ])
    }
    
    private func setupToButtonConstraints() {
        NSLayoutConstraint.activate([
            toButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            toButton.leadingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupToLabelConstraints() {
        NSLayoutConstraint.activate([
            currencyCodeLabelTo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            currencyCodeLabelTo.leadingAnchor.constraint(equalTo: toButton.trailingAnchor, constant: 0)
        ])
    }

    private func setupAmountTFConstraints() {
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: fromButton.bottomAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -120),
            amountTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
        ])
    }
    
    private func setupResultLabelConstraints() {
        NSLayoutConstraint.activate([
            resultTextField.topAnchor.constraint(equalTo: toButton.bottomAnchor, constant: 20),
            resultTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            resultTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 120),
        ])
    }
}
