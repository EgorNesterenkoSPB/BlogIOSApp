//
//  MainViewRouter.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 08.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

final class MainViewRouter:PresenterToRouterMainViewProtocol {
    static func createModule() -> UIViewController? {
        let mainVC = MainViewController()
        
        let presenter: ViewToPresenterMainViewProtocol & InteractorToPresenterMainViewProtocol = MainViewPresenter()
        
        mainVC.presenter = presenter
        mainVC.presenter?.router = MainViewRouter()
        mainVC.presenter?.interactor = MainViewInteractor()
        mainVC.presenter?.interactor?.presenter = presenter
        
        
        return mainVC
    }
    
    
    
}
