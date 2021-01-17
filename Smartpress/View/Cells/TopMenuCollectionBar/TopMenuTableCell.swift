//
//  TopMenuTableCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/7/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

protocol TopMenuTableCellDelegate: AnyObject {
    func didTapTopMenuCell(index: Int)
}

class MenuBar: UITableViewCell {
    
    private var menuItems = MenuItems.statusList
    
    weak var delegate: TopMenuTableCellDelegate?
    
    //MARK: CollectionView Customization
    private var menuCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 20)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        cv.register(MenuCVCell.self, forCellWithReuseIdentifier: MenuCVCell.identifier)
        return cv
    }()
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainAppColor
        return view
    }()
    
    private let grayBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .natural
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.mainAppColor.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    //MARK: Init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(menuCollectionView)
        contentView.addSubview(indicator)
        contentView.addSubview(grayBackground)
        contentView.addSubview(tagsLabel)
        contentView.addSubview(bottomSeparatorView)
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        customLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count - 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCVCell.identifier,
                                                      for: indexPath) as! MenuCVCell
        cell.configure(with: menuItems, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            delegate?.didTapTopMenuCell(index: 0)
        case 1:
            delegate?.didTapTopMenuCell(index: 1)
        case 2:
            delegate?.didTapTopMenuCell(index: 2)
        case 3:
            delegate?.didTapTopMenuCell(index: 3)
        default:
            break
        }
    }
}

//MARK: - EXTENSION
extension MenuBar {
    
    func customLayoutSubviews() {
        
        let SPACE: CGFloat = 13
        
        menuCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        menuCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        menuCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        indicator.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        indicator.leftAnchor.constraint(equalTo: menuCollectionView.leftAnchor, constant: 10).isActive = true
        
        grayBackground.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 0).isActive = true
        grayBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        grayBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        grayBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        tagsLabel.topAnchor.constraint(equalTo: indicator.topAnchor).isActive = true
        tagsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        tagsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        tagsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        bottomSeparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        bottomSeparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
