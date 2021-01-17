//
//  NewsModel.swift
//  Smartpress
//
//  Created by Paul Max on 11/17/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import Foundation

//MARK: NewsURL - новости
struct NewsURL {
    static let url = "https://smartpress.by/SAPI/news/list"
}
// Example:
/// - "id": "236",
/// - "title": "Как получить страховку, если машину разбили во время протеста",
/// - "type": "news",
/// - "short": "",
/// - "link": "\/news\/1044\/",
/// - "date": "14.10.2020 10:04",
/// - "lighting": false,
/// - "important": false,
/// - "tags": [
///         "общество",
///         "мы выяснили"
///         ]

struct NewsModel: Decodable {
    
    let title:      String?
    let short:      String?
    let link:       String?
    let date:       String?
    let lighting:   Bool
    let important:  Bool
    let tags:       [String]
}
