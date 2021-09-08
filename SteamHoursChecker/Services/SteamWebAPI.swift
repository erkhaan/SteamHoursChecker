//
//  SteamWebAPI.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 17.06.2021.
//

import Foundation

class SteamWebAPI {
	private var url: URL?
    
	private func createURL(apiKey: String, steamId: String) {
		url = URL(string: "http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/?key=\(apiKey)&steamid=\(steamId)&format=json")!
	}
    
	public func Request(apiKey: String, steamId: String, completionBlock: @escaping (GetRecentlyPlayedGames) -> Void) {
		   createURL(apiKey: apiKey, steamId: steamId)
		   guard let url = url else {
			   print("wrong url")
			   return
		   }
		   var request = URLRequest(url: url)
		   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		   URLSession.shared.dataTask(with: url){	data, response, error in
			   if let data = data {
				   if let ans = try? JSONDecoder().decode(GetRecentlyPlayedGames.self, from: data) {
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
}

