//
//  averwatchlistsearchresultsadversemediaresults.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverWatchlistSearchAdverseMediaResults: Decodable {
    var datePublished: String?
    var title: String?
    var description: String?
    var name: String?
    var source: String?
    var url: String?
    var matchScore: Float?
    var businessMatchName: String?
    var firstNameMatch: String?
    var middleNameMatch: String?
    var lastNameMatch: String?
    var stateMatch: String?
    var countryMatch: String?
}
