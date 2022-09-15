//
//  SteamWebAPI.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 17.06.2021.
//

import Foundation

final class NetworkService {
    static func requestGameStats(apiKey: String, steamId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let link: String = "http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/"

        guard let url = URL(string: link + "?key=\(apiKey)&steamid=\(steamId)&format=json") else {
            print("wrong url")
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }

        dataTask.resume()
    }
}
