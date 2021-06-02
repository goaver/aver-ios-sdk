//
//  avercheckaddressverification.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckAddressVerification: Decodable {
    var validAddress: Bool?
    var reportedFraud: Bool?
    var streetAddress1: String?
    var streetAddress2: String?
    var city: String?
    var stateOrProvince: String?
    var postalCode: String?
    var country: String?
}
