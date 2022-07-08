//
//  MainViewController.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 05.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter:(ViewToPresenterMainViewProtocol & InteractorToPresenterMainViewProtocol)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI(){
        self.view.backgroundColor = UIColor(named: Constant.backgroundColor)
    }

}

extension MainViewController: PresenterToViewMainViewProtocol {
    
}
