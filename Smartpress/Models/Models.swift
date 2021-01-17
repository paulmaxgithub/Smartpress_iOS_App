//
//  Models.swift
//  Smartpress
//
//  Created by Paul Max on 11/7/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import UIKit

enum MenuItems: String, CaseIterable {
    
    case home =         "ГЛАВНАЯ"
    case news =         "НОВОСТИ"
    case stream =       "СМАРТЭФИР"
    case idea =         "СМАРТИДЕЯ"
    case interview =    "ИНТЕРВЬЮ"
    case search =       "ПОИСК"
    case subscribeButton = ""
    
    static var statusList: [String] {
      return MenuItems.allCases.map { $0.rawValue }
    }
}
