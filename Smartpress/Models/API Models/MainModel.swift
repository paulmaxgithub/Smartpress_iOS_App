//
//  MainModel.swift
//  Smartpress
//
//  Created by Paul Max on 11/17/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import Foundation

struct WebAddressURL {
    static let url = "https://smartpress.by" // for upload a photo
}

struct MainURL {
    static let url = "https://smartpress.by/SAPI/main" // - главная
}

struct MainModel: Decodable {
    
    let news:       [NewsModel]
    let stream:     [StreamModel]
    let idea:       [IdeaModel]
    let interview:  [InterviewModel]
}
