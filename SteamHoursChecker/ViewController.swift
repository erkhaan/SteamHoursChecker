//
//  ViewController.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 13.06.2021.
//

import Cocoa

class GameTime: NSObject{
	@objc dynamic var name: String
	@objc dynamic var twoWeek: String
	@objc dynamic var perDay: String
	@objc dynamic var total: String
	init(name: String, twoWeek: String, perDay: String,total: String){
		self.name = name
		self.twoWeek = twoWeek
		self.perDay = perDay
		self.total = total
	}
}

class ViewController: NSViewController {

	private var url: URL?
	@objc dynamic var playedGames = [GameTime]()

	@IBOutlet weak var gameLabel: NSTextField!
	@IBOutlet weak var playtimePerDay: NSTextField!

	@IBOutlet weak var apiKeyNS: NSTextField!
	@IBOutlet weak var steamIdNS: NSTextField!

	private func createURL(apiKey: String, steamId: String){
		url = URL(string: "http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/?key=\(apiKey)&steamid=\(steamId)&format=json")!
	}

	func mtoh(minutes m: Int) -> Double{
		return Double(m)/60.0
	}

	func formatDouble(_ value:Double) -> String{
		String(format: "%.1f", value)
	}

	@IBAction func updateData(_ sender: NSButton) {
		let apiKey = apiKeyNS.stringValue
		let steamId = steamIdNS.stringValue

		apiRequest(apiKey: apiKey, steamId: steamId){ data in
			DispatchQueue.main.async{
				var sum = 0
				self.playedGames = [GameTime]()
				for i in data.response.games{
					if let time = i.playtime_2weeks, let _ = i.name {
						sum += time
						guard let name = i.name else{
							return
						}
						guard let playtime2weeks = i.playtime_2weeks else{
							return
						}
						guard let playtimeForever = i.playtime_forever else{
							return
						}
						self.playedGames.append(
							GameTime(
								name: name,
								twoWeek: self.formatDouble(self.mtoh(minutes: playtime2weeks)),
								perDay: self.formatDouble(self.mtoh(minutes: playtime2weeks/14)),
								total: self.formatDouble(self.mtoh(minutes: playtimeForever))
							)
						)
					}
				}
				self.gameLabel.stringValue = String(format: "%.1f hours past 2 week", self.mtoh(minutes: sum))
				self.playtimePerDay.stringValue = String(format: "%.1f hours per day", self.mtoh(minutes: sum)/14)
			}
		}
	}

	private func apiRequest(apiKey: String, steamId: String, completionBlock: @escaping (GetRecentlyPlayedGames) -> Void){
		createURL(apiKey: apiKey, steamId: steamId)
		guard let url = url else {
			print("wrong url")
			return
		}
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		URLSession.shared.dataTask(with: url){	data, response, error in
			if let data = data {
				if let ans = try? JSONDecoder().decode(GetRecentlyPlayedGames.self, from: data){
					completionBlock(ans)
				}else{
					print("invalid")
				}
			} else if let error = error {
				print("some error")
				print(error)
			}
		}.resume()
	}

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
