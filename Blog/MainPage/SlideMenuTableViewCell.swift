//
//  SlideMenuTableViewCell.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 09.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell {
    
    static let identefier = "SlideMenuCell"
    
    lazy var backView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()
    
    lazy var iconView:UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
        return view
    }()
    
    lazy var labelView:UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        labelView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.tintColor = .black
        
        self.backgroundColor = UIColor(named: Constant.backgroundColor)
        self.selectionStyle = .none
        
        addSubview(backView)
        backView.addSubview(iconView)
        backView.addSubview(labelView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            labelView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: labelView.trailingAnchor,constant: 10)
        ])
        
    }

}
