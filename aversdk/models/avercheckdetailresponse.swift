//
//  avercheckdetailresponse.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckDetailResponse: Decodable {
    var id: String?
    var groupId: String?
    var thirdPartyIdentifier: String?
    var status: AverCheckStatus
    var checkTypes: [AverCheckType]?
    var checkResults: AverCheckResults?
    var warnings: [AverCheckWarning]?
}
