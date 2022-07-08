//
//  LoginPageViewController.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class LoginViewController:UIViewController {
    
    let titleLabel = UILabel()
    let userEmailEntry = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let userPasswordEntry = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let loginButton = UIButton()
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var passwordEntryCenterXConstraint:NSLayoutConstraint?
    var passwordLabelLeadingConstraint:NSLayoutConstraint?
    let errorLabel = UILabel()
    
    var email = ""
    var password = ""
    var isRegister:Bool = false
    var isValidEmainDomenAddress:Bool = false
    let defaults = UserDefaults.standard
    
    var presenter: (ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
    }
    
    
    //MARK:- UI setup
    
    private func setupUI() {
        self.view.backgroundColor = UIColor(named: Constant.backgroundColor)
        
        navigationController?.navigationBar.isHidden = true
        
        setupLabel(label: titleLabel, text: "My blog", color: .black, scrollView: scrollView) //common function for settings label w/ out font
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        setupLabel(label: passwordLabel, text: "Password:", color: .black, scrollView: scrollView)
        passwordLabel.font = .systemFont(ofSize: 20)
        
        setupTextField(textField: userPasswordEntry, tag: 1, size: 20)
        userPasswordEntry.delegate = self
        userPasswordEntry.isSecureTextEntry = true
        
        loginButton.isEnabled = false
        loginButton.setTitle("Register", for: .normal)
        loginButton.backgroundColor = .lightGray
        loginButton.tintColor = .white
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(userPasswordEntry)
        scrollView.addSubview(loginButton)
        
        passwordEntryCenterXConstraint = userPasswordEntry.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor,constant: 10)
        passwordEntryCenterXConstraint?.isActive = true
        
        passwordLabelLeadingConstraint = passwordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 5)
        passwordLabelLeadingConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userPasswordEntry.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor,constant: 50),
            userPasswordEntry.widthAnchor.constraint(equalToConstant: 200),
            passwordLabel.centerYAnchor.constraint(equalTo: userPasswordEntry.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: userPasswordEntry.bottomAnchor,constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        if let isRegister_ = defaults.object(forKey: Constant.loginSuccess) as? Bool {
            if isRegister_{
                loginButton.titleLabel?.text = "Login"
                self.isRegister = isRegister_
            }
        }
        else{
            setupLabel(label: emailLabel, text: "Email:",color:.black ,scrollView: scrollView)
            emailLabel.font = .systemFont(ofSize: 20)
            
            
            setupTextField(textField: userEmailEntry, tag: 0, size: 20)
            userEmailEntry.delegate = self
            
            scrollView.addSubview(userEmailEntry)
            
            passwordLabelLeadingConstraint?.isActive = false
            passwordEntryCenterXConstraint?.isActive = false
            
            NSLayoutConstraint.activate([
                userPasswordEntry.centerXAnchor.constraint(equalTo: userEmailEntry.centerXAnchor),
                passwordLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
                userEmailEntry.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor,constant: 50),
                userEmailEntry.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor,constant: -10),
                userEmailEntry.widthAnchor.constraint(equalToConstant: 200),
                emailLabel.centerYAnchor.constraint(equalTo: userEmailEntry.centerYAnchor),
                emailLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10),
                emailLabel.rightAnchor.constraint(equalTo: userEmailEntry.leftAnchor,constant: -15)
            ])
            
        
        }
    }
    
    @objc private func loginButtonPressed() {
        
        errorLabel.removeFromSuperview()
        emailLabel.textColor = .black
        passwordLabel.textColor = .black
        
        
        
        if isRegister {
            presenter?.userSelectLogin(password: self.password)
        
        }
        else {
            if isValidEmainDomenAddress{
            
            guard self.email.count != 0 && self.password.count != 0 && self.email != " " && self.password != " " else {
            let bounds = loginButton.bounds
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
                self.loginButton.bounds = CGRect(x: bounds.origin.x - 50, y: bounds.origin.y, width: bounds.width + 1000, height: bounds.height)
                
                self.loginButton.titleLabel?.bounds = CGRect(x: bounds.origin.x - 30, y: bounds.origin.y / 2, width: bounds.width + 60, height: 0)
            } )
        
            if email.count == 0{
                emailLabel.textColor = .red
                setupLabel(label: errorLabel, text: "Please fill email entry", color: .red, scrollView: scrollView)
            }
            else {
                passwordLabel.textColor = .red
                setupLabel(label: errorLabel, text: "Please fill password entry", color: .red, scrollView: scrollView)
            }
            
            NSLayoutConstraint.activate([errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 10),
                                         errorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
            ])
            return}
            
            presenter?.userSelectRegister(email: email, password: password)
         }
            else {
                return
            }
        }
     }
}


//MARK:- TextField Delegate

extension LoginViewController:UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            if let emailText = textField.text {
                self.email = emailText
                self.presenter?.ValidEmailAddressDomen(email: emailText)
                loginButton.isEnabled = true
            }
        case 1:
            if let passwordText = textField.text{
                self.password = passwordText
                loginButton.isEnabled = true
                if isRegister {
                    self.loginButton.backgroundColor = .black
                }
            }
        default:
            break
        }
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField.tag {
        case 0:
            if let emailText = textField.text {
                self.email = emailText
                self.presenter?.ValidEmailAddressDomen(email: emailText)
            }
        case 1:
            if let passwordText = textField.text{
                self.password = passwordText
            }
        default:
            break
        }
        return true
    }
}

//MARK: - PresenterToViewProtocol
extension LoginViewController:PresenterToViewLoginProtocol {
    func onSuccessValidEmailAddressDomen() {
        self.loginButton.backgroundColor = .black
        self.isValidEmainDomenAddress = true
        return
    }
    
    func onFailureValiedEmailAddressDomen(error: String) {
        errorLabel.removeFromSuperview()
        setupLabel(label: errorLabel, text: error, color: .red, scrollView: scrollView)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 10),
            errorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    func onFailureLogin(error: String) {
        present(errorAC(error),animated: true,completion: nil)
    }
    
    func onFailureRegister(error: String) {
        present(errorAC(error),animated: true,completion: nil)
    }
    
    func onSuccessfulLogin() {
        presenter?.successfulLogin()
    }
    
    func onSuccessfulRegister() {
        presenter?.successfulRegister()
    }
    
}
