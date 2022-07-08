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
}

extension LoginAccountPresenter:InteractorToPresenterLoginProtocol {
    func successfulLogin() {
        router?.pushToMainView(on: view)
    }
    
    func succesfulRegister() {
        router?.pushToMainView(on: view)
    }
    
    func failureLogin(error: String) {
        view?.onFailureLogin(error: error)
    }
    
    func failureRegister(error: String) {
        view?.onFailureRegister(error: error)
    }
    
    
}
