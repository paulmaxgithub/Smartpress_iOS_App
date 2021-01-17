//
//  IdeaModel.swift
//  Smartpress
//
//  Created by Paul Max on 11/17/20.
//  Copyright © 2020 Paul Max. All rights reserved.
//

import Foundation

//MARK: IdeaURL - смартидея
struct IdeaURL {
    static let url = "https://smartpress.by/SAPI/idea/list"
}
// Example:
/// - "id": "700",
/// - "title": "Российский разработчик создал “мертвую воду” -  после обработки ей продукты не портятся",
/// - "short": "Главный конструктор ООО &quot;Акустическая Заморозка&quot; Дмитрий Балаболин рассказал Смартидее о своем изобретении, его внедрении и том, что оно может совершить революцию в пищевой промышленности",
/// - "link": "\/idea\/rossiyskiy-razrabotchik-sozdal-mertvuyu-vodu-posle-obrabotki-produkty-ne-portyatsya\/",
/// - "date": "13.10.2020 14:27",
/// - "picture": "\/upload\/iblock\/46e\/балаболин.jpg",
/// - "tags": [
///         "смартидея",
///         "наука"
///         ]

struct IdeaModel: Decodable {
    
    let title:      String?
    let short:      String?
    let link:       String?
    let date:       String?
    let picture:    String?
    let tags:       [String]
}
