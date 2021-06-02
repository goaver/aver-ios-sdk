//
//  avercheckcreaterequest.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckCreateRequest {
    var groupId: String
    var thirdPartyIdentifier: String
    var email: String
    var returnUrl: String = ""
    var language: String = "en"
    var skipPersonalAccessCode: Bool = false
    var overrideThirdPartyIdentifier: Bool = false
}
