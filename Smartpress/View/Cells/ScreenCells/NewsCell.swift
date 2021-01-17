//
//  NewsCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/9/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 1
        return label
    }()
    
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.numberOfLines = 1
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    //MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagsLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomSeparatorView)
        
        customLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CELL CONFIGURATOR
    public func cellConfigure(news: [NewsModel], for indexPath: IndexPath) {
        
        dateLabel.text = String((news[indexPath.row].date)!.dropLast(6))
        tagsLabel.text = "#\((news[indexPath.row].tags).joined(separator: " #"))"
        
        titleLabel.text = news[indexPath.row].title?.html2String
        titleLabel.textColor = news[indexPath.row].important ? .mainAppColor : .black
        
        // Remove LAST SEPARATOR line from tableview
        if indexPath.row == news.lastIndex(where: { (news) -> Bool in
            return true
        }) {
            bottomSeparatorView.isHidden = true
        } else {
            bottomSeparatorView.isHidden = false
        }
    }
}

//MARK: - EXTENSION
extension NewsCell {
    
    private func customLayoutSubviews() {
        
        let SPACE: CGFloat = 13
        
        dateLabel.widthAnchor.constraint(equalToConstant: (contentView.width - (SPACE * 3)) / 4).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: dateLabel.font.lineHeight).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SPACE).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        
        tagsLabel.heightAnchor.constraint(equalToConstant: tagsLabel.font.lineHeight).isActive = true
        tagsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SPACE).isActive = true
        tagsLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: SPACE).isActive = true
        tagsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: SPACE).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor, constant: -SPACE).isActive = true
        
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomSeparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        bottomSeparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
