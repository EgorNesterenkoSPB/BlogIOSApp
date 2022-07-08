//
//  LoginPageProtocols.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

//MARK: - View input (View -> Presenter)
protocol ViewToPresenterLoginProtocol {
    var view: PresenterToViewLoginProtocol?{get set}
    var interactor: PresenterToInteractorLoginProtocol? {get set}
    var router: PresenterToRouterLoginProtocol?{get set}
    func userSelectRegister(email:String,password:String)
    func userSelectLogin(password:String)
}

//MARK: - View output (Presenter -> View)
protocol PresenterToViewLoginProtocol:AnyObject {
    func onSuccessfulLogin()
    func onSuccessfulRegister()
    func onFailureLogin(error:String)
    func onFailureRegister(error:String)
}

//MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginProtocol {
    var presenter: InteractorToPresenterLoginProtocol? {get set}
    func login(password:String)
    func register(email:String,password:String)
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginProtocol {
    func successfulLogin()
    func succesfulRegister()
    func failureLogin(error:String)
    func failureRegister(error:String)
    
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterLoginProtocol {
    static func createModule() -> UINavigationController
    func pushToMainView(on view:PresenterToViewLoginProtocol?)
}
