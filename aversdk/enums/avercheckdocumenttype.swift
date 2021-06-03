//
//  avercheckdocumenttype.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

enum AverCheckDocumentType: String, Decodable {
    case camPhoto = "CamPhoto"
    case passportImage = "PassportImage"
    case naDriverLicense = "NADriverLicense"
    case genericIdentificationCardImage = "GenericIdentificationCardImage"
}
