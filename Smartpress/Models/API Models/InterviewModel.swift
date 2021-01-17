//
//  InterviewModel.swift
//  Smartpress
//
//  Created by Paul Max on 11/17/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import Foundation

//MARK: InterviewURL - интервью
struct InterviewURL {
    static let url = "https://smartpress.by/SAPI/interview/list"
}
// Example:
/// - "id": "671",
/// - "title": "Алексей Бинецкий: Россия и Китай в условиях санкций станут основными спонсорами и партнерами Беларуси",
/// - "short": "Алексей Бинецкий - известный российский адвокат-международник, доктор политических наук, профессор.",
/// - "link": "\/interview\/aleksey-binetskiy-rossiya-i-kitay-v-usloviyakh-sanktsiy-stanut-osnovnymi-sponsorami-i-partnerami-bel\/",
/// - "date": "11.10.2020 15:31",
/// - "picture": "\/upload\/iblock\/de6\/photo_2020-10-12_15-06-02.jpg",
/// - "tags": [
///         "интервью",
///         "бинецкий"
///         ]

struct InterviewModel: Decodable {
    
    let title:      String?
    let short:      String?
    let link:       String?
    let date:       String?
    let picture:    String?
    let tags:       [String]
}
