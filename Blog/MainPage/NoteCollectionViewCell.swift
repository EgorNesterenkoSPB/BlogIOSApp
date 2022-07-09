//
//  NoteCollectionViewCell.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 09.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "noteCell"
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) hasnt been implemented")
    }
    
    func setupCell() {
        self.backgroundColor = .lightGray
    }
}
