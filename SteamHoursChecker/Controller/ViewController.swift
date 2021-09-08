//
//  ViewController.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 13.06.2021.
//

import Cocoa

class GameTime: NSObject {
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

class ViewController: NSViewController {
	@objc dynamic var playedGames = [GameTime]()

    // MARK: IBOutlets

	@IBOutlet weak var gameLabel: NSTextField!
	@IBOutlet weak var playtimePerDay: NSTextField!
	@IBOutlet weak var apiKeyNS: NSTextField!
	@IBOutlet weak var steamIdNS: NSTextField!

	func mtoh(minutes: Int) -> Double {
		return Double(minutes) / 60.0
	}

	func formatDouble(_ value: Double) -> String {
		String(format: "%.1f", value)
	}

	let api = SteamWebAPI()

	@IBAction func updateData(_ sender: NSButton) {
		let apiKey = apiKeyNS.stringValue
		let steamId = steamIdNS.stringValue
		api.request(apiKey: apiKey, steamId: steamId) { data in
			DispatchQueue.main.async {
				var sum = 0
				self.playedGames = [GameTime]()
				for game in data.response.games {
					if let time = game.playtimeTwoWeeks, let name = game.name {
						sum += time
						guard let playtimeTwoWeeks = game.playtimeTwoWeeks else {
							return
						}
						guard let playtimeForever = game.playtimeForever else {
							return
						}
						self.playedGames.append(
							GameTime(
								name: name,
								twoWeek: self.formatDouble(self.mtoh(minutes: playtimeTwoWeeks)),
								perDay: self.formatDouble(self.mtoh(minutes: playtimeTwoWeeks / 14)),
								total: self.formatDouble(self.mtoh(minutes: playtimeForever)))
						)
					}
				}
				self.gameLabel.stringValue = String(format: "%.1f hours past 2 week", self.mtoh(minutes: sum))
				self.playtimePerDay.stringValue = String(format: "%.1f hours per day", self.mtoh(minutes: sum) / 14)
			}
		}
	}

    // MARK: ViewController lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
}
