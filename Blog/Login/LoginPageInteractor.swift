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
        
        self.fetchDataValidEmail(email: email, completion: { [weak self] isValid in
            
            if isValid{
                let encoder = JSONEncoder()
                let rootAccount = Account(email: email, password: password)
                
                if let encoded = try? encoder.encode(rootAccount) {
                    self?.defaults.set(encoded, forKey: Constant.accountKey)
                    self?.defaults.set(true,forKey: Constant.loginSuccess)
                    self?.presenter?.successfulRegister()
                }
                else {
                    self?.presenter?.failureRegister(error: "Coudnt save account, try again")
                }
            }
            else {
                self?.presenter?.failureRegister(error: "The email not found")
            }
        })
    }
    
    func isValidEmailAddressDomen(email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailTest.evaluate(with: email) {
            presenter?.successfulValidEmailAddressDomen()
        }
        else {
            presenter?.failureValidEmailAddressDomen(error: "Email address domen isnt valid")
        }
    }
    
    private func fetchDataValidEmail(email:String, completion: @escaping (Bool) -> Void) {
        let urlString = "http://apilayer.net/api/check?access_key=\(Constant.networkEmailKey)&email=\(email)"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {[weak self] data, response,error in
                if let _ = error {
                    completion(false)
                }
                else {
                    if let safeData = data,let _ = self?.parseJSON(safeData) {
                        completion(true)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    private func parseJSON(_ emailData:Data) -> EmailData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(EmailData.self, from: emailData)
            let decodedEmailData = EmailData(isValid:decodedData.isValid)
            return decodedEmailData
        } catch  {
            return nil
        }
    }

}
