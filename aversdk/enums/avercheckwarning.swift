//
//  avercheckwarning.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

enum AverCheckWarning: String, Decodable {
    case country = "Country"
    case state = "State"
    case ipVpnTor = "IPVpnTor"
    case address = "Address"
    case emailAddress = "EmailAddress"
    case watchlistHitsFound = "WatchlistHitsFound"
    case adverseMediaFound = "AdverseMediaFound"
    case sameEmailFound = "SameEmailFound"
    case sameIdDocumentFound = "SameIdDocumentFound"
    case sameNameFound = "SameNameFound"
}
