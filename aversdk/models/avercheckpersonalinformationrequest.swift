//
//  avercheckpersonalinformationrequest.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverCheckPersonalInformationRequest: Decodable {
    var email: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var gender: String?
    var dateOfBirth: String?
    var stateProvince: String?
    var country: String?
    var streetAddress1: String?
    var streetAddress2: String?
    var city: String?
    var postalCode: String?
}
