//
//  CM_LoginViewUI.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//
//

import UIKit

protocol CM_LoginViewUIDelegate {
    func notifyUserAndPassword(name: String, password: String)
}

class CM_LoginViewUI: UIView{
    var delegate: CM_LoginViewUIDelegate?
    var navigationController: UINavigationController?
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logoIcon")
        image.clipsToBounds = true
        return image
    }()
    
    lazy var userNameTextField: CM_TextField = {
        let textField = CM_TextField(placeholder: "Username")
        textField.delegate = self
        return textField
    }()

    lazy var userPasswordTextField: CM_TextField = {
        let textField = CM_TextField(placeholder: "Password")
        textField.delegate = self
        return textField
    }()

    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.backgroundColor =   #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.isEnabled = false
        return button
    }()
    
    public var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor =  #colorLiteral(red: 0.7229098678, green: 0.3283879757, blue: 0.1109213307, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    public convenience init(
        navigation: UINavigationController,
        delegate: CM_LoginViewUIDelegate){
            self.init()
            self.delegate = delegate
            self.navigationController = navigation
            
            let gestoTap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard(_:)))
            self.addGestureRecognizer(gestoTap)
            
            setUI()
            setConstraints()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI(){
        self.backgroundColor = CM_NetworkManager.shared.backgroundColor
        self.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(userPasswordTextField)
        containerView.addSubview(continueButton)
        self.addSubview(errorLabel)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            userPasswordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            userPasswordTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            userPasswordTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            continueButton.topAnchor.constraint(equalTo: userPasswordTextField.bottomAnchor, constant: 50),
            continueButton.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            errorLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
        ])
    }
    
    @objc func dissmisKeyboard(_ sender: UITapGestureRecognizer){
        self.endEditing(true)
    }
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.notifyUserAndPassword(name: userNameTextField.text ?? "", password: userPasswordTextField.text ?? "")
    }
}

extension CM_LoginViewUI: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        continueButton.isEnabled = (!(userNameTextField.text?.isEmpty ?? false) && !(userPasswordTextField.text?.isEmpty ?? false))
        if continueButton.isEnabled {
            continueButton.backgroundColor =   CM_NetworkManager.shared.textColor
        } else {
            continueButton.backgroundColor =   #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
