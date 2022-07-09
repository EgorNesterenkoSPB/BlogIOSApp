//
//  LoginPageInteractor.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import Combine

final class LoginAccountInteractor:PresenterToInteractorLoginProtocol {
    
    var presenter: InteractorToPresenterLoginProtocol?
    let defaults = UserDefaults.standard
    private var cancellable = Set<AnyCancellable>()
    
    
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
        
        self.fetchEmailValidCombine(email: email).sink(receiveCompletion: {[weak self] completion in
            switch completion {
            case .failure(let error):
                self?.presenter?.failureRegister(error: "\(error)")
            case .finished:
                let rootAccount = Account(email: email, password: password)
                if let encoded = try? JSONEncoder().encode(rootAccount) {
                    self?.defaults.set(encoded, forKey: Constant.accountKey)
                    self?.defaults.set(true,forKey: Constant.loginSuccess)
                    self?.presenter?.successfulRegister()
                }
                else {
                    self?.presenter?.failureRegister(error: "Coudnt save account, try again")
                }
            }
        }, receiveValue: { data in
            print(data)
        }).store(in: &cancellable)
        
        
//        self.fetchDataValidEmail(email: email, completion: { [weak self] isValid in
//
//            if isValid{
//                let encoder = JSONEncoder()
//                let rootAccount = Account(email: email, password: password)
//
//                if let encoded = try? encoder.encode(rootAccount) {
//                    self?.defaults.set(encoded, forKey: Constant.accountKey)
//                    self?.defaults.set(true,forKey: Constant.loginSuccess)
//                    self?.presenter?.successfulRegister()
//                }
//                else {
//                    self?.presenter?.failureRegister(error: "Coudnt save account, try again")
//                }
//            }
//            else {
//                self?.presenter?.failureRegister(error: "The email not found")
//            }
//        })
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
    
//    private func fetchDataValidEmail(email:String, completion: @escaping (Bool) -> Void) {
//        let urlString = "http://apilayer.net/api/check?access_key=\(Constant.networkEmailKey)&email=\(email)"
//
//        if let url = URL(string: urlString){
//
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) {[weak self] data, response,error in
//                if let _ = error {
//                    completion(false)
//                }
//                else {
//                    if let safeData = data,let _ = self?.parseJSON(safeData) {
//                        completion(true)
//                    }
//                }
//            }
//            task.resume()
//        }
//
//    }
    
//    private func parseJSON(_ emailData:Data) -> EmailData? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(EmailData.self, from: emailData)
//            let decodedEmailData = EmailData(isValid:decodedData.isValid)
//            return decodedEmailData
//        } catch  {
//            return nil
//        }
//    }
    
    func fetchEmailValidCombine(email:String) -> Future<EmailData,Error> {
        
        let urlString = "http://apilayer.net/api/check?access_key=\(Constant.networkEmailKey)&email=\(email)"
        
        let publisher = Future<EmailData,Error>.self {[weak self] promise in
            guard let self = self,let url = URL(string: urlString) else {
                print("invalid url")
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url).tryMap {(data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                    self.presenter?.failureRegister(error: "Bad http response status code")
                }
                return data
                } .decode(type: EmailData.self, decoder: JSONDecoder()).receive(on: DispatchQueue.main).sink(receiveCompletion: { completion_ in
                    if case let .failure(error) = completion_ {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0))}).store(in: &self.cancellable)
        }
        return publisher
    }
    
    enum NetworkError: Error {
        case invalidURL
        case responseError
        case unknown
    }

}
