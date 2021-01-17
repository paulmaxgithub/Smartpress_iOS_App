//
//  NewsViewController.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    private var tagCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 70, height: 17)
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(TagMenuCell.self, forCellWithReuseIdentifier: TagMenuCell.cellIdentifier())
        return cv
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self,
                       forCellReuseIdentifier: NewsCell.cellIdentifier())
        return table
    }()
    
    //additional class properties
    private var newsDataResponse:   [NewsModel] = []
    private var arrayOfTags:        [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        
        getNewsResults()
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
                    /// tableView
                    self.newsDataResponse = Array(result.reversed())
                    /// collectionView
                    for tags in result {
                        for tag in tags.tags {
                            if !self.arrayOfTags.contains(tag) {
                                self.arrayOfTags.append(tag)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tagCollectionView.reloadData()
                    }
                } catch let error {
                    debugPrint(error)
                }
            }
        }.resume()
    }
}

//MARK: - CollectionView Delegate
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return arrayOfTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: TagMenuCell.cellIdentifier(),
                                                      for: indexPath) as! TagMenuCell
        item.configureCell(with: arrayOfTags, for: indexPath)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableView Delegate
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let contentView = UIView()
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(self.tagCollectionView)
        NSLayoutConstraint.activate([
            tagCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tagCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        return contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIdentifier(),
                                                 for: indexPath) as! NewsCell
        cell.cellConfigure(news: newsDataResponse, for: indexPath)
        //cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailNewsVC()
        vc.link = newsDataResponse[indexPath.row].link
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
