//
//  DetailNewsVC.swift
//  Smartpress
//
//  Created by Paul Max on 11/23/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class DetailNewsVC: UIViewController {
    
    //NavigationController Items
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Smartpress_Logo")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let leftBarButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Arrow_Back"), for: .normal)
        return button
    }()
    
    private let rightBarButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Auth_Block_Icon"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    //Items in View
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.adjustedContentInsetDidChange()
        return scrollView
    }()
    
    private let titleText: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
        textView.textAlignment = NSTextAlignment.left
        textView.sizeToFit()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.orange
        return textView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
        label.numberOfLines = 2
        return label
    }()
    
    private let detailText: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
        textView.textAlignment = NSTextAlignment.left
        textView.sizeToFit()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    private let shareLabel: UILabel = {
        let label = UILabel()
        label.text  = "Поделиться:"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 1
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3
        return button
    }()
    
    //TableView
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self,
                       forCellReuseIdentifier: NewsCell.cellIdentifier())
        return table
    }()
    
    //Additional Properties
    public var link:                String!
    private let detailNewsURL =     DetailNewsURL.url
    private var detailNewsDataResponse:   [DetailNewsModel] = []
    
    private let newsURL = NewsURL.url
    private var newsDataResponse: [NewsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.addSubview(titleText)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(tagsLabel)
        scrollView.addSubview(detailText)
        scrollView.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        // Items
        let leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        // Logo
        navigationController?.navigationBar.topItem?.titleView = imageView
        
        leftBarButton.addTarget(
            self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
    }
    
    @objc private func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetailNewsResult()
        getNewsResults()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let SPACE: CGFloat = 13
        
        scrollView.frame = view.bounds
        
        titleText.frame = CGRect(x: SPACE, y: SPACE, width: view.width - SPACE * 2, height: 100)
        
        dateLabel.frame = CGRect(x: SPACE,
                                 y: titleText.bottom + SPACE,
                                 width: (view.width - (SPACE * 3)) / 4,
                                 height: 15)
        
        tagsLabel.frame = CGRect(x: dateLabel.right + SPACE,
                                 y: titleText.bottom + SPACE,
                                 width: view.width - dateLabel.width - 50,
                                 height: 15)
        
        detailText.frame = CGRect(x: SPACE, y: dateLabel.bottom + SPACE, width: view.width - SPACE * 2, height: 400)
        
        tableView.frame = CGRect(x: 0, y: detailText.bottom + SPACE, width: view.width, height: 160 * 4)
    }
    
    //MARK: - API Request, JSON Parsing for View
    private func getDetailNewsResult() {
        guard let url = URL(string: self.detailNewsURL + link) else {
            debugPrint("URL is nil!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if data != nil, error == nil {
                do {
                    let result = try JSONDecoder().decode([DetailNewsModel].self, from: data!)
                    self.detailNewsDataResponse = result
                    DispatchQueue.main.async {
                        self.titleText.text = self.detailNewsDataResponse[0].title
                        self.dateLabel.text = String((self.detailNewsDataResponse[0].date)!.dropLast(6))
                        self.tagsLabel.text = (self.detailNewsDataResponse[0].tags).joined(separator: " #")
                        self.detailText.text = self.detailNewsDataResponse[0].detail?.html2String
                        self.tableView.reloadData()
                    }
                } catch let error {
                    debugPrint(error)
                }
            }
        }.resume()
    }
    
    //MARK: - API Request, JSON Parsing for TableView
    private func getNewsResults() {
        guard let url = URL(string: self.newsURL) else {
            debugPrint("URL is nil!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if data != nil, error == nil {
                do {
                    let result = try JSONDecoder().decode([NewsModel].self, from: data!)
                    self.newsDataResponse = Array(result.reversed())
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    debugPrint(error)
                }
            }
        }.resume()
    }
}

//MARK: - UITableView Delegate
extension DetailNewsVC: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Новости по теме"
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
