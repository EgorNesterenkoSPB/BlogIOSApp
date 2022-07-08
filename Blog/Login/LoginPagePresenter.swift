//
//  LoginPagePresenter.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation

final class LoginAccountPresenter:ViewToPresenterLoginProtocol {
    
    
    var view: PresenterToViewLoginProtocol?
    var interactor: PresenterToInteractorLoginProtocol?
    var router: PresenterToRouterLoginProtocol?
    
    
    func userSelectRegister(email: String, password: String) {
        interactor?.register(email: email, password: password)
    }
    
    func userSelectLogin(password: String) {
        interactor?.login(password: password)
    }
    
    func ValidEmailAddressDomen(email: String) {
        interactor?.isValidEmailAddressDomen(email: email)
    }
}

extension LoginAccountPresenter:InteractorToPresenterLoginProtocol {
    func successfulValidEmailAddressDomen() {
        view?.onSuccessValidEmailAddressDomen()
    }
    
    func failureValidEmailAddressDomen(error: String) {
        view?.onFailureValiedEmailAddressDomen(error: error)
    }
    
    func successfulLogin() {
        router?.pushToMainView(on: view)
    }
    
    func successfulRegister() {
        router?.pushToMainView(on: view)
    }
    
    func failureLogin(error: String) {
        view?.onFailureLogin(error: error)
    }
    
    func failureRegister(error: String) {
        view?.onFailureRegister(error: error)
    }
    
    
}
