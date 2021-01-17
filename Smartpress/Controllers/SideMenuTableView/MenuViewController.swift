//
//  MenuViewController.swift
//  Smartpress
//
//  Created by Paul Max on 11/4/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

protocol MenuControllerDelegate: AnyObject {
    func didSelectMenuItem(named: MenuItems)
}

class MenuViewController: UITableViewController {
    
    weak public var delegate: MenuControllerDelegate?
    
    private let menuItems: [MenuItems]
    
    //MARK: Menu Table Customization
    init(with menuItems: [MenuItems]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(SideMenuTableViewCell.self,
                           forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        tableView.register(SubscribeButtonCell.self,
                           forCellReuseIdentifier: SubscribeButtonCell.identifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSubscribeButton() {
    }
    
    //MARK: - Table Customization
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != menuItems.lastIndex(of: .subscribeButton) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as! SideMenuTableViewCell
            cell.configure(with: menuItems, for: indexPath)
            return cell
        } else {
            let unclickableCell = tableView.dequeueReusableCell(
            withIdentifier: SubscribeButtonCell.identifier) as! SubscribeButtonCell
            unclickableCell.selectionStyle = .none
            return unclickableCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != menuItems.lastIndex(of: .subscribeButton) {
            return getHeightForRow(model: menuItems.count)
        } else {
            return getHeightForRow(model: menuItems.count) / 2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Relay to delegate about menu item seletion
        let selectedItem = menuItems[indexPath.row]
        
        // Cancel the transition when tapping on a cell
        if indexPath.row == menuItems.lastIndex(of: .subscribeButton) {
            return
        } else {
            delegate?.didSelectMenuItem(named: selectedItem)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
