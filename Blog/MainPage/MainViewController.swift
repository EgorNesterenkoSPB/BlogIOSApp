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
    var containerView = UIView() // for slideMenu
    var slideMenuView = UITableView()
    let slideMenuViewHeight = UIScreen.main.bounds.height
    let slideMenuViewDataSource:[Int:(UIImage?,String)] = [
        0:(UIImage(systemName: "chart.bar"),"My activity")
    ]
    var notes:Array<Note> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    //MARK: - Set up UI
    private func setupUI(){
        self.view.backgroundColor = UIColor(named: Constant.backgroundColor)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
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
        
        slideMenuView.isScrollEnabled = false
        slideMenuView.delegate = self
        slideMenuView.dataSource = self
        slideMenuView.register(SlideMenuTableViewCell.self, forCellReuseIdentifier: SlideMenuTableViewCell.identefier)
        slideMenuView.backgroundColor = UIColor(named: Constant.backgroundColor)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func slideUpViewTapped() { // hide slideMenu
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.containerView.alpha = 0
            self?.slideMenuView.frame = CGRect(x: 0, y: 0, width: 0, height: self?.slideMenuViewHeight ?? screenSize.height)
        }, completion: nil)
    }

}

//MARK: - PresenterToViewProtocol
extension MainViewController: PresenterToViewMainViewProtocol {
    func onSuccessCreateNote() {
        
    }
    
    func onFailureCreateNote() {
        
    }
    
    
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
            header.setup(mainViewVC: self)
            header.delegate = self
            return header
        }
        fatalError("Unable to dequeue header")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.size.width, height: 50)
    }

}

//MARK: - HeaderButtonsProtocol
extension MainViewController:HeaderCollectionReusableViewProtocol {
    func showSlideMenu() {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        containerView.frame = self.view.frame
        window?.addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideUpViewTapped))
        containerView.addGestureRecognizer(tapGesture)
        
        let screenSize = UIScreen.main.bounds.size
        
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.containerView.alpha = 0.8
            self?.slideMenuView.frame = CGRect(x:0, y:0, width: (screenSize.width / 2) + 100, height: self?.slideMenuViewHeight ?? screenSize.height)
        }, completion: nil)
        
        
//        slideMenuView.frame = CGRect(x: 0, y:0, width: (screenSize.width / 2) - 20, height: slideMenuViewHeight)
        slideMenuView.separatorStyle = .none
        window?.addSubview(slideMenuView)
    }
    
    func openCreatingNoteView() {
        
        
    }
    
    
}

//MARK: - TableView Protocols
extension MainViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        slideMenuViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SlideMenuTableViewCell.identefier, for: indexPath) as? SlideMenuTableViewCell else {
            fatalError("unable to dequeue slideMenu cell")
        }
        cell.iconView.image = slideMenuViewDataSource[indexPath.row]?.0
        cell.labelView.text = slideMenuViewDataSource[indexPath.row]?.1
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 70))
        
        let label = UILabel(frame: CGRect(x: headerView.frame.width / 2 , y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10))
        label.text = "Menu"
        label.font = .boldSystemFont(ofSize: 23)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
}
