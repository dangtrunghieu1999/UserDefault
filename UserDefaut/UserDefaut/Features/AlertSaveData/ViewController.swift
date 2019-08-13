//
//  ViewController.swift
//  UserDefaut
//
//  Created by Dang Trung Hieu on 8/10/19.
//  Copyright © 2019 Dang Trung Hieu. All rights reserved.
//

import UIKit

struct Keys {
    static let result = "result text"
}


class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    // MARK: - UI Elements
    
    fileprivate lazy var inputTextField: CustomeTextField = {
        let textField = CustomeTextField()
        textField.layer.borderWidth = 1
        textField.placeholder = "Input text field"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.addTarget(self, action: #selector(textFieldValueChange), for: .editingChanged)
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.gray
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(alertButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        layoutInputTextField()
        layoutNextButton()
        checkForSavedName()
    }
    
    // MARK: - UI Actions
    
    @objc func textFieldValueChange(_ textField: UITextField) {
        let textField: String = inputTextField.text ?? ""
        if(textField != ""){
            saveButton.isUserInteractionEnabled = true
            saveButton.backgroundColor = UIColor.red
        }else {
            saveButton.isUserInteractionEnabled = false
            saveButton.backgroundColor = UIColor.gray
        }
    }
    
    @objc func alertButton() {
        let alert = UIAlertController(title: "Thông báo", message: inputTextField.text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        saveResult()
    }
    
    func saveResult() {
        defaults.set(inputTextField.text ?? "", forKey: Keys.result)
    }
    
    
    func checkForSavedName() {
        let name = defaults.value(forKey: Keys.result) as? String ?? ""
        inputTextField.text = name
    }
    
    // MARK: - Setup Layouts
    let widthTextField = UIScreen.main.bounds.width
    
    private func layoutInputTextField() {
        view.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            }
            else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(90)
            }
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
    }
    
    private func layoutNextButton() {
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(inputTextField.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Extension

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
