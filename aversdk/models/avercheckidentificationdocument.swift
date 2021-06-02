//
//  avercheckidentificationdocument.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public struct AverCheckIdentificationDocument: Decodable {
    var type: String?
    var frontId: String?
    var backId: String?
    var expirationDate: String?
    var documentNumber: String?
}
