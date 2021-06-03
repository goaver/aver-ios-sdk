//
//  averwatchlistsearchrequest.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverWatchlistSearchRequest: Decodable {
    var groupId:String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var businessName: String?
    var country: String?
    var stateOrProvince: String?
    var fileContent: String?
    var fileName: String?
    var categories: [AverWatchlistSearchCategory]?
}
