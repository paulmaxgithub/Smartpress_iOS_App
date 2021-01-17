//
//  InterviewCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/18/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class InterviewCell: UITableViewCell {
    
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
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let allTextLabel: UILabel = {
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
        contentView.addSubview(photoImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagsLabel)
        contentView.addSubview(allTextLabel)
        contentView.addSubview(bottomSeparatorView)
        
        customLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        dateLabel.text = nil
        tagsLabel.text = nil
        allTextLabel.text = nil
    }
    
    //MARK: - CELL CONFIGURATOR
    public func cellConfigure(interview: [InterviewModel], for indexPath: IndexPath) {
        
        dateLabel.text = String((interview[indexPath.row].date)!.dropLast(6))
        tagsLabel.text = "#\((interview[indexPath.row].tags).joined(separator: " #"))"
        allTextLabel.text = interview[indexPath.row].title
        
        // Getting Photo Data from JSON
        guard let url = URL(
            string: WebAddressURL.url + (interview[indexPath.row].picture!)) else {
                return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data)
                }
            }
        }
        
        // Remove LAST SEPARATOR line from tableview
        if indexPath.row == interview.lastIndex(where: { (interview) -> Bool in
            return true
        }) {
            bottomSeparatorView.isHidden = true
        } else {
            bottomSeparatorView.isHidden = false
        }
    }
}

//MARK: - EXTENSION
extension InterviewCell {
    
    private func customLayoutSubviews() {
        
        let SPACE: CGFloat = 13
        let imageHeight: CGFloat = contentView.width / 4 * 3 /// image height equals 3/4 of contentView width
        
        dateLabel.widthAnchor.constraint(equalToConstant: (contentView.width - (SPACE * 3)) / 4).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: dateLabel.font.lineHeight).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SPACE).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        
        tagsLabel.heightAnchor.constraint(equalToConstant: tagsLabel.font.lineHeight).isActive = true
        tagsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SPACE).isActive = true
        tagsLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: SPACE).isActive = true
        tagsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        
        photoImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        photoImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: SPACE).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        
        allTextLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: SPACE).isActive = true
        allTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        allTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        allTextLabel.bottomAnchor.constraint(equalTo: bottomSeparatorView.topAnchor, constant: -SPACE).isActive = true
        
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomSeparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE).isActive = true
        bottomSeparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
