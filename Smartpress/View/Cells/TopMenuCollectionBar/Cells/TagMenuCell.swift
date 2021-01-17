//
//  TagMenuCell.swift
//  Smartpress
//
//  Created by Paul Max on 12/5/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class TagMenuCell: UICollectionViewCell {
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .mainAppColor
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 1
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(tagLabel)
        
        customLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with tagItem: [String], for indexPath: IndexPath) {
        tagLabel.text = "#\(tagItem[indexPath.row])"
    }
}

extension TagMenuCell {
    
    private func customLayoutSubviews() {
        
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tagLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
