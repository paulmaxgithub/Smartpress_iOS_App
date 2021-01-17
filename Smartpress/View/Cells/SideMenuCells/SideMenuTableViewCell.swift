//
//  SideMenuTableViewCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    static let identifier = "SideMenuTableViewCell"
    
    private var menuItems: [MenuItems]?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.alpha = 0.37
        return view
    }()
    
    //MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = 40
        iconImageView.frame = CGRect(x: 20,
                                     y: 0,
                                     width: imageSize,
                                     height: imageSize)
        
        label.frame = CGRect(x: iconImageView.right + 20,
                             y: 0,
                             width: contentView.width - iconImageView.width - 6,
                             height: contentView.height / 4)
        
        separatorView.frame = CGRect(x: 0,
                                     y: contentView.bottom,
                                     width: contentView.width,
                                     height: 1.0)
        
        iconImageView.center.y = contentView.center.y
        label.center.y = contentView.center.y
    }
    
    public func configure(with menuItems: [MenuItems], for indexPath: IndexPath) {
        
        self.menuItems = menuItems
        iconImageView.image = UIImage(named: "icons\(String(indexPath.row))")
        label.text = menuItems[indexPath.row].rawValue
        
        if menuItems[indexPath.row].rawValue == "ПОИСК" {
            label.textColor = .mainAppColor
        }
    }
}
