//
//  SmartIdeaViewController.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

class SmartIdeaViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(IdeaCell.self,
                       forCellReuseIdentifier: IdeaCell.identifier)
        return table
    }()
    
    private let ideaURL = "https://smartpress.by/SAPI/idea/list"
    private var ideaDataResponse: [IdeaModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getIdeaResults()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - API Request, JSON Parsing
    private func getIdeaResults() {
        guard let url = URL(string: self.ideaURL) else {
            debugPrint("URL is nil!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if data != nil, error == nil {
                do {
                    let result = try JSONDecoder().decode([IdeaModel].self, from: data!)
                    DispatchQueue.main.async {
                        self.ideaDataResponse = Array(result.reversed())
                        self.tableView.reloadData()
                    }
                } catch let error {
                    debugPrint(error)
                }
            }
        }.resume()
    }
}

extension SmartIdeaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TopMenuTableCell.identifier) as? TopMenuTableCell else {
                return nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideaDataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IdeaCell.identifier,
                                                 for: indexPath) as! IdeaCell
        guard ideaDataResponse.indices.contains(0) else {
            print("NILNILNILNILNILNIL")
            return cell
            
        }
        cell.cellConfigure(idea: ideaDataResponse, for: indexPath)
        //cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 381
    }
}
