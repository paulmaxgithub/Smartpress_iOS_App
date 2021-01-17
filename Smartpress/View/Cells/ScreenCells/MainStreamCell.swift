//
//  MainStreamCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/28/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class MainStreamCell: UITableViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let liveLabel: UILabel = {
        let label = UILabel()
        label.text = "Live"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mainAppColor
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.numberOfLines = 1
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Смартэфир")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let showVideoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3
        return button
    }()
    
    private let allTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
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
        view.layer.borderColor = UIColor.mainAppColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    //MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(liveLabel)
        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(showVideoButton)
        contentView.addSubview(allTextLabel)
        contentView.addSubview(bottomSeparatorView)

        customLayoutSubviews()
        
        showVideoButton.addTarget(
            self, action: #selector(didTapShowVideoButton), for: .touchUpInside)
    }
    
    @objc private func didTapShowVideoButton(_ sender: UIButton) {
        print("DID TAPPED!!!")
        sender.flash()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CELL CONFIGURATOR
    public func cellConfigure(stream: [StreamModel], for indexPath: IndexPath) {
        
        titleLabel.text = stream[indexPath.row].title
        allTextLabel.text = stream[indexPath.row].short?.html2String
        
        // Getting Photo Data from JSON
//        guard let url = URL(
//            string: WebAddressURL.url + (stream[indexPath.row].picture!)) else {
//                return
//        }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    self.photoImageView.image = UIImage(data: data)
//                }
//            }
//        }
        
        // Logic of "LIVE"-label for TRUE status
        if stream[indexPath.row].status {
            liveLabel.isHidden = false
        } else {
            liveLabel.isHidden = true
        }
        
        // Check if "dateLabel" has value for current cell
        if stream[indexPath.row].date == nil {
            showVideoButton.setTitle("Смотреть", for: .normal)
            showVideoButton.backgroundColor = .mainAppColor
            showVideoButton.isUserInteractionEnabled = true
        } else {
            let today = Date()
            let unknown = stream[indexPath.row].date?.toDate()
            if unknown! > today {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let showTime = formatter.string(from: unknown!)
                showVideoButton.setTitle("Завтра в \(showTime)", for: .normal)
                showVideoButton.backgroundColor = .systemGray
                showVideoButton.isUserInteractionEnabled = false
            } else {
                showVideoButton.setTitle("Смотреть", for: .normal)
                showVideoButton.backgroundColor = .mainAppColor
                showVideoButton.isUserInteractionEnabled = true
            }
        }
}
}

//MARK: - EXTENSION
extension MainStreamCell {
    
    private func customLayoutSubviews() {
        
        let SPACE: CGFloat = 13
        
        photoImageView.widthAnchor.constraint(equalToConstant: contentView.width / 2.5).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 137 + SPACE * 2).isActive = true
        photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SPACE).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE + 3).isActive = true
        
        liveLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: SPACE * 5).isActive = true
        liveLabel.heightAnchor.constraint(equalToConstant: SPACE * 2).isActive = true
        liveLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: SPACE - 2).isActive = true
        liveLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -7).isActive = true
        
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SPACE + 5).isActive = true
        logoImageView.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: SPACE).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: SPACE).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: SPACE).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        
        showVideoButton.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: SPACE).isActive = true
        showVideoButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SPACE).isActive = true
        showVideoButton.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        
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

