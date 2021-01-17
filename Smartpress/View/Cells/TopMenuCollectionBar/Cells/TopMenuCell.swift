//
//  TopMenuCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/8/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class TopMenuCell: UICollectionViewCell {
    
    private let menuItemsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(menuItemsLabel)
        
        customLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with menuItems: [String], for indexPath: IndexPath) {
        menuItemsLabel.text = menuItems[indexPath.row + 1]
    }
}

extension TopMenuCell {
    
    private func customLayoutSubviews() {
        
        NSLayoutConstraint.activate([
            menuItemsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuItemsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            menuItemsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            menuItemsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
