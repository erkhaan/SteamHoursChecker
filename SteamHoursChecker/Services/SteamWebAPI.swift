//
//  SteamWebAPI.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 17.06.2021.
//

import Foundation

class SteamWebAPI {
    public func request(apiKey: String, steamId: String, completionBlock: @escaping (GetRecentlyPlayedGames) -> Void) {
        let link: String = "http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/"

        guard let url = URL(string: link + "?key=\(apiKey)&steamid=\(steamId)&format=json") else {
            print("wrong url")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let ans = try? JSONDecoder().decode(GetRecentlyPlayedGames.self, from: data) {
                    completionBlock(ans)
                } else {
                    print("invalid")
                }
            } else if let error = error {
                print("URLSession data task error: \(error)")
            }
        }.resume()
    }
}
