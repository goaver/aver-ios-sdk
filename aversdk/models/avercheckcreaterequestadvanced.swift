//
//  avercheckcreaterequestadvanced.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverCheckCreateRequestAdvanced: Decodable {
    var groupId: String
    var thirdPartyIdentifier: String
    var email: String
    var returnUrl: String = ""
    var language: String = "en"
    var skipPersonalAccessCode: Bool = false
    var overrideThirdPartyIdentifier: Bool = false
    var checkTypes: [AverCheckType]?
    var supplementalDocumentTypes: [AverCheckSupplementalDocumentType]?
    var watchlistSearchCategories: [AverWatchlistSearchCategory]?
    var watchlistRecheckInterval: AverWatchlistSearchRecheckInterval?
}
