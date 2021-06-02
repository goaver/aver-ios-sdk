//
//  avercheckipanalysisresults.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckIpAnalysisResults: Decodable {
    var vpnOrTor: Bool?
    var ip: String?
    var fraudScore: String?
    var recentAbuse: Bool?
    var isp: String?
    var host: String?
    var timezone: String?
    var localTime: String?
    var position: Double?
    var country: String?
    var city: String?
    var state: String?
    var operatingSystem: String?
    var browser: String?
    var deviceBrand: String?
    var deviceModel: String?
}
