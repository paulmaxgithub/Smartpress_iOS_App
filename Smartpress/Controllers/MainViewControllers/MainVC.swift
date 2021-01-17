//
//  MainVC.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit
import SideMenu

class MainVC: UIViewController, MenuControllerDelegate, TopMenuBarDelegate {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Smartpress_Logo")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let leftBarButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Burger"), for: .normal)
        return button
    }()
    
    private let rightBarButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Auth_Block_Icon"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TopMenuBar.self,
                       forCellReuseIdentifier: TopMenuBar.cellIdentifier())
        table.register(MainStreamCell.self,
                       forCellReuseIdentifier: MainStreamCell.cellIdentifier())
        table.register(NewsCell.self,
                       forCellReuseIdentifier: NewsCell.cellIdentifier())
        table.register(StreamCell.self,
                       forCellReuseIdentifier: StreamCell.cellIdentifier())
        table.register(IdeaCell.self,
                       forCellReuseIdentifier: IdeaCell.cellIdentifier())
        table.register(BannerCell.self,
                       forCellReuseIdentifier: BannerCell.cellIdentifier())
        return table
    }()
    
    // Properties:
    private var menuItems =         MenuItems.statusList
    private var sideMenu:           SideMenuNavigationController?
    private let sideMenuManager =   SideMenuManager.default
    //private var menuBarIsHidden: Bool?
    
    
    private var newsDataResponse:        [NewsModel] = []
    private var streamDataResponse:      [StreamModel] = []
    private var ideaDataResponse:        [IdeaModel] = []
    private var interviewDataResponse:   [InterviewModel] = []
    
    private let newsController =        NewsViewController()
    private let streamController =      StreamViewController()
    private let ideaController =        IdeaViewController()
    private let interviewController =   InterviewViewController()
    private let searchController =      SearchViewController()
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: NavigationBar Customization
        // NavigationBar Color && Status Bar Color
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .mainAppColor
        // Items
        let leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        // Logo
        navigationController?.navigationBar.topItem?.titleView = imageView
        
        //MARK: SideMenu Customization
        let menu = MenuViewController(with: MenuItems.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenuManager.leftMenuNavigationController = sideMenu
        sideMenuManager.leftMenuNavigationController?.presentationStyle = .viewSlideOutMenuIn
        sideMenuManager.leftMenuNavigationController?.presentationStyle.onTopShadowOpacity = 1
        sideMenuManager.leftMenuNavigationController?.presentDuration = 0.5
        sideMenuManager.leftMenuNavigationController?.dismissDuration = 0.5
        sideMenuManager.rightMenuNavigationController = nil
        sideMenuManager.addPanGestureToPresent(toView: view)
        leftBarButton.addTarget(self, action: #selector(leftBarButtonTapped), for: .touchUpInside)
        
        //MARK: TableView Customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        
        addChildControllers()
        getMainResults()
    }
    
    @objc private func leftBarButtonTapped() {
        present(sideMenu!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: TopMenuBarDelegate
    func didTapTopMenuCell(named: String) {
        switch named {
        case "НОВОСТИ":
            allViewIsHidden()
        case "СМАРТЭФИР":
            allViewIsHidden()
            streamController.view.isHidden = false
            streamController.view.frame = CGRect(
                x: 0, y: 40, width: view.width, height: view.height - 40)
        case "СМАРТИДЕЯ":
            allViewIsHidden()
            ideaController.view.isHidden = false
            ideaController.view.frame = CGRect(
                x: 0, y: 40, width: view.width, height: view.height - 40)
        case "ИНТЕРВЬЮ":
            allViewIsHidden()
            interviewController.view.isHidden = false
            interviewController.view.frame = CGRect(
                x: 0, y: 40, width: view.width, height: view.height - 40)
        default:
            break
        }
    }
    
    //MARK:  SideMenuControllerDelegate
    func didSelectMenuItem(named: MenuItems) {
        sideMenu?.dismiss(animated: true)
        switch named {
        case .home:
            allViewIsHidden()
        case .news:
            allViewIsHidden()
            newsController.view.isHidden = false
        case .stream:
            allViewIsHidden()
            streamController.view.isHidden = false
            streamController.view.frame = view.bounds
        case .idea:
            allViewIsHidden()
            ideaController.view.isHidden = false
            ideaController.view.frame = view.bounds
        case .interview:
            allViewIsHidden()
            interviewController.view.isHidden = false
            interviewController.view.frame = view.bounds
        case .search:
            allViewIsHidden()
            searchController.view.isHidden = false
            searchController.view.frame = view.bounds
        case .subscribeButton:
            allViewIsHidden()
        }
    }
    
    //MARK: - API Request, JSON Parsing
    private func getMainResults() {
        guard let url = URL(string: MainURL.url) else {
            debugPrint("URL is nil!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if data != nil, error == nil {
                do {
                    let result = try JSONDecoder().decode(MainModel.self, from: data!)
                    DispatchQueue.main.async {
                        self.newsDataResponse = result.news.reversed()
                        self.streamDataResponse = result.stream
                        //self.ideaDataResponse = result.idea
                        //self.interviewDataResponse = result.interview
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
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TopMenuBar.cellIdentifier()) as? TopMenuBar else {
                return nil
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0, 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainStreamCell.cellIdentifier(),
                                                     for: indexPath) as! MainStreamCell
            cell.cellConfigure(stream: streamDataResponse, for: indexPath)
            cell.selectionStyle = .none
            return cell
            //        case 4:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: IdeaCell.cellIdentifier(),
            //                                                     for: indexPath) as! IdeaCell
            //            //cell.cellConfigure(idea: ideaDataResponse, for: indexPath)
            //            cell.selectionStyle = .none
        //            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellIdentifier(),
                                                     for: indexPath) as! BannerCell
            cell.cellConfigure(image: #imageLiteral(resourceName: "TestBanner"))
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIdentifier(),
                                                     for: indexPath) as! NewsCell
            cell.cellConfigure(news: newsDataResponse, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(newsController, animated: true)
    }
}

//MARK: - SideMenuNavigationControllerDelegate
extension MainVC: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        leftBarButton.setImage(#imageLiteral(resourceName: "Arrow_Back"), for: .normal)
        view.alpha = 0.5
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        leftBarButton.setImage(#imageLiteral(resourceName: "Burger"), for: .normal)
        view.alpha = 1.0
    }
}

//MARK: ViewControllers Customization
extension MainVC {
    
    private func addChildControllers() {
        addChild(newsController)
        addChild(streamController)
        addChild(ideaController)
        addChild(interviewController)
        addChild(searchController)
        
        view.addSubview(newsController.view)
        view.addSubview(streamController.view)
        view.addSubview(ideaController.view)
        view.addSubview(interviewController.view)
        view.addSubview(searchController.view)
        
        newsController.view.frame = view.bounds
        streamController.view.frame = view.bounds
        ideaController.view.frame = view.bounds
        interviewController.view.frame = view.bounds
        searchController.view.frame = view.bounds
        
        newsController.didMove(toParent: self)
        streamController.didMove(toParent: self)
        ideaController.didMove(toParent: self)
        interviewController.didMove(toParent: self)
        searchController.didMove(toParent: self)
        
        allViewIsHidden()
    }
    
    private func allViewIsHidden() {
        newsController.view.isHidden = true
        streamController.view.isHidden = true
        ideaController.view.isHidden = true
        interviewController.view.isHidden = true
        searchController.view.isHidden = true
    }
}
