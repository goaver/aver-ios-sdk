//
//  averwatchlistsearchresults.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverWatchlistSearchResults: Decodable {
    var id: String
    var groupId: String
    var organizationId: String
    var checkId: String?
    var status: String?
    var searchDate: String?
    var searchType: String?
    var recheckInterval: Int?
    var lastRecheckDate: String?
    var searchCriteria: AverWatchlistSearchCriteria?
    var watchlistResults: [AverWatchlistSearchWatchlistResults]?
    var adverseMediaResults: [AverWatchlistSearchAdverseMediaResults]?
}
