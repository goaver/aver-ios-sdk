//
//  averchecktype.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

enum AverCheckType: String, Decodable {
    case emailVerification = "EmailVerification"
    case documentVerification = "DocumentVerification"
    case photoVerification = "PhotoVerification"
    case accreditedInvestor = "AccreditedInvestor"
    case watchlist = "Watchlist"
    case visualWatchlist = "VisualWatchlist"
    case riskProfiling = "RiskProfiling"
    case addressVerification = "AddressVerification"
}
