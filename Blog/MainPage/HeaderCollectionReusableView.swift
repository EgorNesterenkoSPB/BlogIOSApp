//
//  HeaderCollectionReusableView.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 09.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

protocol HeaderCollectionReusableViewProtocol {
    func showSlideMenu()
    func openCreatingNoteView()
}

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static let identefier = "headerCollectionReusableView"
    
    private let createNoteButton = UIButton()
    private let titleLabel = UILabel()
    private let slideMenuButton = UIButton()
    
    var delegate:HeaderCollectionReusableViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(mainViewVC:MainViewController) {
        self.backgroundColor = UIColor(named: Constant.backgroundColor)
        
        titleLabel.text = "Notes"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        self.addSubview(titleLabel)
        
        
        slideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        slideMenuButton.imageView?.tintColor = .black
        slideMenuButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        slideMenuButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        slideMenuButton.addTarget(self, action: #selector(showSlideMenu(_:)), for: .touchUpInside)
        self.addSubview(slideMenuButton)
        
        createNoteButton.translatesAutoresizingMaskIntoConstraints = false
        createNoteButton.imageView?.tintColor = .black
        createNoteButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        createNoteButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        createNoteButton.addTarget(self, action: #selector(openCreatingNoteView(_:)), for: .touchUpInside)
        self.addSubview(createNoteButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            slideMenuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 30),
            slideMenuButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            createNoteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -30),
            createNoteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    @objc func showSlideMenu(_ sender:UIButton) {
        delegate?.showSlideMenu()
    }
    
    @objc func openCreatingNoteView(_ sender:UIButton) {
        delegate?.openCreatingNoteView()
    }
    
    
}
