//
//  StreamViewController.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(StreamCell.self, forCellReuseIdentifier: StreamCell.cellIdentifier())
        return table
    }()
    
    private let streamURL = StreamURL.url
    private var streamDataResponse: [StreamModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStreamResults()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 2, width: view.width, height: view.height)
    }
    
    //MARK: - API Request, JSON Parsing
    private func getStreamResults() {
        guard let url = URL(string: self.streamURL) else {
            debugPrint("URL is nil!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if data != nil, error == nil {
                do {
                    let result = try JSONDecoder().decode([StreamModel].self, from: data!)
                    DispatchQueue.main.async {
                        self.streamDataResponse = result
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
extension StreamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamDataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StreamCell.cellIdentifier(),
                                                 for: indexPath) as! StreamCell
        cell.cellConfigure(stream: streamDataResponse, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
