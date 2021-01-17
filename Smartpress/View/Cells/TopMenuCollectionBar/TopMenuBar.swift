//
//  TopMenuBar.swift
//  Smartpress
//
//  Created by Paul Max on 11/7/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

protocol TopMenuBarDelegate: AnyObject {
    func didTapTopMenuCell(named: String)
}

class TopMenuBar: UITableViewCell {
    
    private var menuItems = MenuItems.statusList
    private var arrayOfTags: [String] = []
    
    weak public var delegate: TopMenuBarDelegate?
    
    //MARK: CollectionView(s) Customization
    private var menuCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 17)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(TopMenuCell.self, forCellWithReuseIdentifier: TopMenuCell.cellIdentifier())
        return cv
    }()
    
    private var tagCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 70, height: 17)
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .systemGray5
        cv.register(TagMenuCell.self, forCellWithReuseIdentifier: TagMenuCell.cellIdentifier())
        return cv
    }()
    
    private let indicatorMenuBarItem: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainAppColor
        return view
    }()
    
    //MARK: Init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubview(menuCollectionView)
        contentView.addSubview(tagCollectionView)
        contentView.addSubview(indicatorMenuBarItem)
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        customLayoutSubviews()
        getNewsResults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API Request, JSON Parsing
    private func getNewsResults() {
        guard let url = URL(string: NewsURL.url) else {
            debugPrint("URL is nil!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if data != nil, error == nil {
                do {
                    let result = try JSONDecoder().decode([NewsModel].self, from: data!)
                    for tags in result {
                        for tag in tags.tags {
                            if !self.arrayOfTags.contains(tag) {
                                self.arrayOfTags.append(tag)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tagCollectionView.reloadData()
                    }
                } catch let error {
                    debugPrint(error)
                }
            }
        }.resume()
    }
}

extension TopMenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return arrayOfTags.count
        } else {
            return menuItems.count - 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopMenuCell.cellIdentifier(),
                                                          for: indexPath) as! TopMenuCell
            cell.configure(with: menuItems, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagMenuCell.cellIdentifier(),
                                                          for: indexPath) as! TagMenuCell
            cell.configureCell(with: arrayOfTags, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Relay to delegate about menu item seletion
        if collectionView == menuCollectionView {
            let selectedItem = menuItems[indexPath.row + 1].description
            delegate?.didTapTopMenuCell(named: selectedItem)
        } else {
            return
        }
    }
}

//MARK: - EXTENSION
extension TopMenuBar {
    
    func customLayoutSubviews() {
        
        menuCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        menuCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        menuCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        indicatorMenuBarItem.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor).isActive = true
        indicatorMenuBarItem.widthAnchor.constraint(equalToConstant: 100).isActive = true
        indicatorMenuBarItem.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        indicatorMenuBarItem.leftAnchor.constraint(equalTo: menuCollectionView.leftAnchor, constant: 10).isActive = true
        
        tagCollectionView.topAnchor.constraint(equalTo: indicatorMenuBarItem.bottomAnchor, constant: 0).isActive = true
        tagCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        tagCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        tagCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
