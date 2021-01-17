//
//  ViewController.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit
import SideMenu

class MainViewController: UIViewController, MenuControllerDelegate {
    
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
        table.register(TopMenuTableCell.self,
                       forCellReuseIdentifier: TopMenuTableCell.identifier)
        table.register(MainSmartBroadcastCell.self,
                       forCellReuseIdentifier: MainSmartBroadcastCell.identifier)
        table.register(PreviewSmartBroadcastCell.self,
                       forCellReuseIdentifier: PreviewSmartBroadcastCell.identifier)
        table.register(PreviewActualNewsCell.self,
                       forCellReuseIdentifier: PreviewActualNewsCell.identifier)
        table.register(PreviewWithPhotoCell.self,
                       forCellReuseIdentifier: PreviewWithPhotoCell.identifier)
        table.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        return table
    }()
    
    private var sideMenu: SideMenuNavigationController?
    
    private var menuItems = MenuItems.statusList
    
    private let newsController =            NewsViewController()
    private let smartBroadcastController =  SmartBroadcastViewController()
    private let smartIdeaController =       SmartIdeaViewController()
    private let interviewController =       InterviewViewController()
    private let searchController =          SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: NavigationBar Customization
        // NavigationBar Color // Status Bar Color
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
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.rightMenuNavigationController = nil
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        //MARK: SideMenu Customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        leftBarButton.addTarget(self,
                                action: #selector(leftBarButtonTapped),
                                for: .touchUpInside)
        
        addChildControllers()
    }
    
    @objc private func leftBarButtonTapped() {
        present(sideMenu!, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func didSelectMenuItem(named: MenuItems) {
        sideMenu?.dismiss(animated: true)
        switch named {
        case .home:
            allViewIsHidden()
        case .news:
            allViewIsHidden()
            newsController.view.isHidden = false
        case .broadcast:
            allViewIsHidden()
            smartBroadcastController.view.isHidden = false
        case .idea:
            allViewIsHidden()
            smartIdeaController.view.isHidden = false
        case .interview:
            allViewIsHidden()
            interviewController.view.isHidden = false
        case .search:
            allViewIsHidden()
            searchController.view.isHidden = false
        case .subscribeButton:
            allViewIsHidden()
        }
    }
    
    private func addChildControllers() {
        addChild(newsController)
        addChild(smartBroadcastController)
        addChild(smartIdeaController)
        addChild(interviewController)
        addChild(searchController)
        
        view.addSubview(newsController.view)
        view.addSubview(smartBroadcastController.view)
        view.addSubview(smartIdeaController.view)
        view.addSubview(interviewController.view)
        view.addSubview(searchController.view)
        
        newsController.view.frame = view.bounds
        smartBroadcastController.view.frame = view.bounds
        smartIdeaController.view.frame = view.bounds
        interviewController.view.frame = view.bounds
        searchController.view.frame = view.bounds
        
        newsController.didMove(toParent: self)
        smartBroadcastController.didMove(toParent: self)
        smartIdeaController.didMove(toParent: self)
        interviewController.didMove(toParent: self)
        searchController.didMove(toParent: self)
        
        allViewIsHidden()
    }
    
    private func allViewIsHidden() {
        newsController.view.isHidden = true
        smartBroadcastController.view.isHidden = true
        smartIdeaController.view.isHidden = true
        interviewController.view.isHidden = true
        searchController.view.isHidden = true
    }
}

//MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let menuCollectionCell = tableView.dequeueReusableCell(
                withIdentifier: TopMenuTableCell.identifier,
                for: indexPath) as! TopMenuTableCell
            return menuCollectionCell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainSmartBroadcastCell.identifier,
                for: indexPath) as! MainSmartBroadcastCell
            cell.cellConfigure()
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PreviewSmartBroadcastCell.identifier,
                for: indexPath) as! PreviewSmartBroadcastCell
            cell.cellConfigure()
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PreviewWithPhotoCell.identifier,
                for: indexPath) as! PreviewWithPhotoCell
            cell.configure()
            cell.selectionStyle = .none
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BannerCell.identifier,
                for: indexPath) as! BannerCell
            cell.configure()
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PreviewActualNewsCell.identifier,
                for: indexPath) as! PreviewActualNewsCell
            cell.configure(for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 40
        case 1, 2:
            return 281
        case 5:
            return 381
        case 9:
            return 191
        default:
            return 133
        }
    }
}
