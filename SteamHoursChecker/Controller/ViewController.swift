//
//  ViewController.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 13.06.2021.
//

import Cocoa

final class ViewController: NSViewController {

    // MARK: - Properties

    @objc dynamic var playedGames = [GameTime]()
    let daysAmount = 14

    // MARK: - IBOutlets

    @IBOutlet weak var gameLabel: NSTextField!
    @IBOutlet weak var playtimePerDay: NSTextField!
    @IBOutlet weak var apiKeyNS: NSTextField!
    @IBOutlet weak var steamIdNS: NSTextField!

    @IBAction func updateData(_ sender: NSButton) {
        loadStats()
    }

    // MARK: - Network Methods

    private func loadStats() {
        NetworkService.requestGameStats(apiKey: apiKeyNS.stringValue, steamId: steamIdNS.stringValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.parse(stats: data)
            case .failure(let error):
                print("\(error)")
            }
        }
    }

    private func parse(stats data: Data) {
        let decoder = JSONDecoder()
        guard let ans = try? decoder.decode(RecentGames.self, from: data) else {
            print("Invalid JSON format")
            return
        }
        display(games: ans)
    }

    private func display(games recentGames: RecentGames) {
        guard
            let playedGames = format(recentGames),
            let totalPlaytime = playtime(of: recentGames)
        else {
            return
        }

        let totalHours = minutesToHours(totalPlaytime)
        let playtimeString = String(format: "%.1f hours per day", totalHours / Double(self.daysAmount))
        let gameLabelString = String(format: "%.1f hours past 2 week", totalHours)

        DispatchQueue.main.async {
            self.playedGames = playedGames
            self.gameLabel.stringValue = playtimeString
            self.playtimePerDay.stringValue = gameLabelString
        }
    }

    // MARK: - Format methods

    private func minutesToHours(_ minutes: Int) -> Double {
        Double(minutes) / 60.0
    }

    private func formatDouble(_ value: Double) -> String {
        String(format: "%.1f", value)
    }

    private func playtime(of games: RecentGames) -> Int? {
        var sum = 0
        for game in games.response.games {
            guard let playtime = game.playtimeTwoWeeks else {
                return nil
            }
            sum += playtime
        }
        return sum
    }

    private func format(_ games: RecentGames) -> [GameTime]? {
        var playedArray = [GameTime]()

        for game in games.response.games {
            guard
                let playtimeTwoWeeks = game.playtimeTwoWeeks,
                let name = game.name,
                let playtimeForever = game.playtimeForever
            else {
                return nil
            }
            let twoWeek = formatDouble(minutesToHours(playtimeTwoWeeks))
            let perDay = formatDouble(minutesToHours(playtimeTwoWeeks / daysAmount))
            let total = formatDouble(minutesToHours(playtimeForever))
            playedArray.append(GameTime(
                name: name,
                twoWeek: twoWeek,
                perDay: perDay,
                total: total))
        }
        return playedArray
    }

    // MARK: - VC lifecycle

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
