//
//  SubscribeButtonCell.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class SubscribeButtonCell: UITableViewCell {
    
    static let identifier = "SubscribeButtonCell"
    
    public let subscribeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "BUTTON"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(subscribeButton)
        subscribeButton.addTarget(self, action: #selector(didTapSubscribeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subscribeButton.setImage(nil, for: .normal)
        subscribeButton.backgroundColor = nil
        subscribeButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subscribeButton.center = contentView.center
        subscribeButton.frame.size = CGSize(width: contentView.width - 20,
                                            height: contentView.height - 10)
    }
    
    @objc private func didTapSubscribeButton() {
        
    }
}
