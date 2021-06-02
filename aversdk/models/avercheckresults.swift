//
//  avercheckresponse.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckResults: Decodable {
    var watchlistSearchId: String?
    var attestations: AverCheckAttestations?
    var personalInformation: AverCheckPersonalInformation?
    var identificationDocument: AverCheckIdentificationDocument?
    var photoVerification: AverCheckPhotoVerification?
    var addressVerification: AverCheckAddressVerification?
    var riskProfile: AverCheckRiskProfile?
    var warnings: [String]?
}
