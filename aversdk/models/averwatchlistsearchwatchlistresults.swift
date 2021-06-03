//
//  averwatchlistsearchwatchlistresults.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverWatchlistSearchWatchlistResults: Decodable {
    var matchConfidence: Float
    var watchlistName: String?
    var matchName: String?
    var firstNameMatch: String?
    var lastNameMatch: String?
    var middleNameMatch: String?
    var businessNameMatch: String?
    var stateMatch: String?
    var countryMatch: String?
    var additionalInformation: Dictionary<String,String>?
}
