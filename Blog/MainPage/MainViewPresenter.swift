//
//  MainViewPresenter.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 08.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation

final class MainViewPresenter:ViewToPresenterMainViewProtocol {
    var view: PresenterToViewMainViewProtocol?
    var interactor: PresenterToInteractorMainViewProtocol?
    var router: PresenterToRouterMainViewProtocol?
    
    
}

extension MainViewPresenter: InteractorToPresenterMainViewProtocol {
    
}
