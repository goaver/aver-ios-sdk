//
//  averemailanalysisresults.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverEmailAnalysisResults: Decodable {
    var overallScore: Int?
    var suspect: Bool?
    var validAddress: Bool?
    var temporaryDisposable: Bool?
    var catchAllShared: Bool?
    var honeyPotSpamTrap: Bool?
    var recentAbuse: Bool?
    var commonProvider: Bool?
    var deliverability: Bool?
    var validDNSConfig: Bool?
    var smtpConfigScore: Int?
    var frequentComplainer: Bool?
}
