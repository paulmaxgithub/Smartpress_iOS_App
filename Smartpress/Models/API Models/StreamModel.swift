//
//  StreamModel.swift
//  Smartpress
//
//  Created by Paul Max on 11/17/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import Foundation

//MARK: StreamURL - эфиры
struct StreamURL {
    static let url = "https://smartpress.by/SAPI/stream/list"
}
// Example:
/// "id": "2213",
/// "title": "Владимир Янковский",
/// "position": "Режиссер, актер, сценарист – о том, Почему премьера  фильма \"Купала\" прошла в Москве, а не в Минске?
///         Когда ждать национальную премьеру  и ждать ли вообще? Как снимают кино во время пандемии?",
/// "short": "Почемупремьера  фильма \"Купала\"прошла в Москве, а не в Минске? Какой эффект произвел \"Купала\" накинофестивале в Москве?
///       Когда ждать национальную премьеру  и ждать ли вообще?",
/// "date": "27.11.2020 14:30:00",
/// "picture": "\/upload\/resize_cache\/iblock\/26e\/400_300_2\/maxresdefault.jpg",
/// "status" :false,
/// "link": null

struct StreamModel: Decodable {
    
    let title:      String?
    let position:   String?
    let short:      String?
    let date:       String?
    let picture:    String?
    let status:     Bool        // live status
    let link:       String?
}
