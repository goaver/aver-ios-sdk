//
//  avercheckriskprofile.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckRiskProfile: Decodable {
    var facialMatchConfidence: Int?
    var ipAndDeviceAnalysisResults: AverCheckIpAnalysisResults?
    var emialAnalysisResults: AverEmailAnalysisResults?
}
