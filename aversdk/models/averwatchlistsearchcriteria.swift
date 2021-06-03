//
//  averwatchlistsearchcriteria.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverWatchlistSearchCriteria: Decodable {
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var businessName: String?
    var country: String?
    var stateProvince: String?
}
