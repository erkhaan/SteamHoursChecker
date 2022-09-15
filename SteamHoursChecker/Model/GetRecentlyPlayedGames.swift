//
//  GetRecentlyPlayedGames.swift
//  SteamHoursChecker
//
//  Created by Erkhaan on 13.06.2021.
//

import Foundation

struct GetRecentlyPlayedGames: Codable {
	var response: Response
}

struct Response: Codable {
	var games: [Game]
}

struct Game: Codable {
	var appId: Int?
	var name: String?
	var playtimeTwoWeeks: Int?
	var playtimeForever: Int?
	var imgIconUrl: String?
	var imgLogoUrl: String?
	var playtimeWindowsForever: Int?
	var playtimeMacForever: Int?
	var playtimeLinuxForever: Int?

    enum CodingKeys: String, CodingKey {
        case appId
        case name
        case playtimeTwoWeeks = "playtime_2weeks"
        case playtimeForever = "playtime_forever"
        case imgIconUrl = "img_icon_url"
        case imgLogoUrl = "img_logo_url"
        case playtimeWindowsForever = "playtime_windows_forever"
        case playtimeMacForever = "playtime_mac_forever"
        case playtimeLinuxForever = "playtime_linux_forever"
    }
}

// MARK: - Response Example
/*
{
  "response": {
	"total_count": 19,
	"games": [
	  {
		"appid": 381210,
		"name": "Dead by Daylight",
		"playtime_2weeks": 3007,
		"playtime_forever": 26023,
		"img_icon_url": "3d52bda003b28428330a6a08f4b3e1f12a7d4955",
		"img_logo_url": "78a3f76693dbcd5dd80b5fcf531e8b81b3dd3163",
		"playtime_windows_forever": 26017,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 335300,
		"name": "DARK SOULS™ II: Scholar of the First Sin",
		"playtime_2weeks": 1299,
		"playtime_forever": 10622,
		"img_icon_url": "6e665503e93d1383b774a68dfea23ac7afc0e3aa",
		"img_logo_url": "6ca16aa1b83311e5e3e8f0f0c2b8046f5d9e95a8",
		"playtime_windows_forever": 1299,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 570940,
		"name": "DARK SOULS™: REMASTERED",
		"playtime_2weeks": 201,
		"playtime_forever": 953,
		"img_icon_url": "d74cfa4f3a2070f45ad8ce44e5f61a6507ee00b6",
		"img_logo_url": "fbad2989ed9549c4d456eb91fb28e0e6da54af9c",
		"playtime_windows_forever": 953,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 449730,
		"name": "Ahnayro: The Dream World",
		"playtime_2weeks": 86,
		"playtime_forever": 86,
		"img_icon_url": "5209e2fc8055c648a868cab9c58027d1b03c984b",
		"img_logo_url": "2b94b130ddddc090c41b28a482de896d09a53dcf",
		"playtime_windows_forever": 86,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 343930,
		"name": "Fort Defense",
		"playtime_2weeks": 84,
		"playtime_forever": 84,
		"img_icon_url": "6c2a85fbe6d2ae630470193073981c5fc5feee2b",
		"img_logo_url": "c1cb7883c1ecec32957627f7f8008528f67771f4",
		"playtime_windows_forever": 84,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 1145960,
		"name": "The White Door",
		"playtime_2weeks": 78,
		"playtime_forever": 78,
		"img_icon_url": "be2710df86ef82bc6dfc8ce45e320206b3ef2790",
		"img_logo_url": "5a8c9baccc80d9690b5670a074a65c5f3bbac554",
		"playtime_windows_forever": 78,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 464920,
		"name": "Surviving Mars",
		"playtime_2weeks": 72,
		"playtime_forever": 72,
		"img_icon_url": "6c0bbf943ed725a16304161b89061ac1d37f6a2a",
		"img_logo_url": "1cd2a32fde1c5ca1ebeb81d4304e6761361d03f1",
		"playtime_windows_forever": 72,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 228200,
		"name": "Company of Heroes ",
		"playtime_2weeks": 53,
		"playtime_forever": 167,
		"img_icon_url": "df92dc239acb3cf5d3e3eba645f3df2aaf7f91ad",
		"img_logo_url": "87aa009e93d5aa56a55d0e9056708d018ddd6483",
		"playtime_windows_forever": 120,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 253920,
		"name": "Gorky 17",
		"playtime_2weeks": 52,
		"playtime_forever": 52,
		"img_icon_url": "6a8eda1df2035590871726bbda6c437d18ad89e3",
		"img_logo_url": "709514c7cebae01981e10869bc24df892b5b4c8b",
		"playtime_windows_forever": 52,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 432150,
		"playtime_2weeks": 43,
		"playtime_forever": 91,
		"playtime_windows_forever": 43,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 385200,
		"playtime_2weeks": 38,
		"playtime_forever": 86,
		"playtime_windows_forever": 38,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 410590,
		"playtime_2weeks": 37,
		"playtime_forever": 85,
		"playtime_windows_forever": 37,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 274900,
		"name": "Murder Miners",
		"playtime_2weeks": 31,
		"playtime_forever": 31,
		"img_icon_url": "0ba9a54e98ca963a8cabee36325f873f0b164c62",
		"img_logo_url": "922d51756e33529ada722cf1c5b618445d93177c",
		"playtime_windows_forever": 31,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 431270,
		"playtime_2weeks": 26,
		"playtime_forever": 73,
		"playtime_windows_forever": 26,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 596440,
		"playtime_2weeks": 22,
		"playtime_forever": 69,
		"playtime_windows_forever": 22,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 1494440,
		"name": "Garbage: Hobo Prophecy",
		"playtime_2weeks": 21,
		"playtime_forever": 21,
		"img_icon_url": "2327daf8f0d6ddebc20644c29ef19c1d1b50ef09",
		"img_logo_url": "b9e47686452d18dc85274ea419861e18b64cf2c0",
		"playtime_windows_forever": 21,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 416270,
		"playtime_2weeks": 21,
		"playtime_forever": 68,
		"playtime_windows_forever": 21,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 345920,
		"playtime_2weeks": 20,
		"playtime_forever": 20,
		"playtime_windows_forever": 20,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  },
	  {
		"appid": 351030,
		"name": "Pixel Puzzles Ultimate",
		"playtime_2weeks": 10,
		"playtime_forever": 58,
		"img_icon_url": "1720e286eea6bbd19a61f271793e6885ac7908cb",
		"img_logo_url": "17c6a709d7dfdd47ff1ca1659c3c22f6df5b561d",
		"playtime_windows_forever": 10,
		"playtime_mac_forever": 0,
		"playtime_linux_forever": 0
	  }
	]
  }
}
*/
