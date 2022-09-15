//
//  GameTime.swift
//  SteamHoursChecker
//
//  Created by Erkhaan  on 16.09.2022.
//

import Foundation

final class GameTime: NSObject {
    @objc dynamic var name: String
    @objc dynamic var twoWeek: String
    @objc dynamic var perDay: String
    @objc dynamic var total: String
    init(name: String, twoWeek: String, perDay: String, total: String) {
        self.name = name
        self.twoWeek = twoWeek
        self.perDay = perDay
        self.total = total
    }
}
