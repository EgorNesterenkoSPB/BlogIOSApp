//
//  MainViewProtocols.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 08.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

//MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMainViewProtocol {
    var view: PresenterToViewMainViewProtocol? {get set}
    var interactor: PresenterToInteractorMainViewProtocol?{get set}
    var router: PresenterToRouterMainViewProtocol? {get set}
    
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewMainViewProtocol {
    
}

//MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainViewProtocol {
    var presenter:InteractorToPresenterMainViewProtocol? {get set}
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainViewProtocol {
    
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMainViewProtocol {
    static func createModule() -> UIViewController?
}
