//
//  avercheckpersonalinformation.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckPersonalInformation: Decodable {
    var email: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var gender: String?
    var dateOfBirth: String?
    var stateProvince: String?
    var country: String?
}
