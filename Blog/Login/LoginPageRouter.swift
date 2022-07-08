//
//  LoginPageRouter.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class LoginAccoutRouter:PresenterToRouterLoginProtocol {
    static func createModule() -> UINavigationController {
        
        let loginVC = LoginViewController()
        
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        let presenter:ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginAccountPresenter()
        
        loginVC.presenter = presenter
        loginVC.presenter?.router = LoginAccoutRouter()
        loginVC.presenter?.view = loginVC
        loginVC.presenter?.interactor = LoginAccountInteractor()
        loginVC.presenter?.interactor?.presenter = presenter
        
        return navigationController

    }
    
    func pushToMainView(on view: PresenterToViewLoginProtocol?) {
                    DispatchQueue.main.async {
        if let mainVC = MainViewRouter.createModule() {
            let viewController = view as! LoginViewController
            viewController.navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }
    
    

    
    
}
