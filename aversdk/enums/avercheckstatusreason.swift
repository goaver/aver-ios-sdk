//
//  avercheckstatusreason.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public enum AverCheckStatusReason{
    case MissingDocuments
    case UnreadableDocumentsOrMissingVerificationInformation
    case ExpiredDocuments
    case SuspiciousDocumentsOrImages
    case FacialVerificationFailed
    case UnderageApplicant
}

