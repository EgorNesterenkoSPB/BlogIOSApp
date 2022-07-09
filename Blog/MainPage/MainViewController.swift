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
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var notes:Array<Note> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    //MARK: - Set up UI
    private func setupUI(){
        self.view.backgroundColor = UIColor(named: Constant.backgroundColor)
        
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identefier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identefier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(named: Constant.backgroundColor)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

//MARK: - PresenterToViewProtocol
extension MainViewController: PresenterToViewMainViewProtocol {
    
}


//MARK: - CollectionViewProtcols
extension MainViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identefier, for: indexPath) as? NoteCollectionViewCell {
        cell.setupCell()
        return cell
        }
        fatalError("Unable to dequeue note cell")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize (width: view.frame.size.width - 30, height: view.frame.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identefier, for: indexPath) as? HeaderCollectionReusableView {
            header.setup()
            return header
        }
        fatalError("Unable to dequeue header")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.size.width, height: 50)
    }

}
