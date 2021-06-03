//
//  avercheckstatusreason.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

enum AverCheckStatusReason: String, Decodable {
    case missingDocuments = "MissingDocuments"
    case unreadableDocumentsOrMissingVerificationInformation = "UnreadableDocumentsOrMissingVerificationInformation"
    case expiredDocuments = "ExpiredDocuments"
    case suspiciousDocumentsOrImages = "SuspiciousDocumentsOrImages"
    case facialVerificationFailed = "FacialVerificationFailed"
    case underageApplicant = "UnderageApplicant"
}

