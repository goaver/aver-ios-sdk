//
//  avercheckcreateresponse.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckCreateResponse : Decodable {
    var checkId: String?
    var thirdPartyIdentifier: String?
    var url: String?
}
