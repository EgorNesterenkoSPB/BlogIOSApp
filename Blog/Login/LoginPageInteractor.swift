//
//  LoginPageInteractor.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation

final class LoginAccountInteractor:PresenterToInteractorLoginProtocol {
    
    var presenter: InteractorToPresenterLoginProtocol?
    
    let defaults = UserDefaults.standard
    
    func login(password: String) {
        if let savedAccount = defaults.object(forKey: Constant.accountKey) as? Data {
            let decoder = JSONDecoder()
            if let decodedAccount = try? decoder.decode(Account.self,from:savedAccount) {
                if decodedAccount.password == password {
                    presenter?.successfulLogin()
                }
                else {
                    presenter?.failureLogin(error: "Password is wrong,try again")
                }
            }
        }
    }
    
    func register(email: String, password: String) {
        let encoder = JSONEncoder()
        let rootAccount = Account(email: email, password: password)

        if let encoded = try? encoder.encode(rootAccount) {
            defaults.set(encoded, forKey: Constant.accountKey)
            defaults.set(true,forKey: Constant.loginSuccess)
            presenter?.succesfulRegister()
        }
        else {
            presenter?.failureRegister(error: "Coudnt save account, try again")
        }
    }

}
