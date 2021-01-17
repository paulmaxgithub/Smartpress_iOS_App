//
//  BannerCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/10/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class BannerCell: UITableViewCell {
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                bannerImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                bannerImageView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    //MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(bannerImageView)
        
        customLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CELL CONFIGURATOR
    public func cellConfigure(image: UIImage) {
        
        bannerImageView.image = image
    }
}

//MARK: - EXTENSION
extension BannerCell {
    
    private func customLayoutSubviews() {

//        let imageHeight: CGFloat = contentView.width / 4 * 3 /// image height equals 3/4 of contentView width
//
//        bannerImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        bannerImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        bannerImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
