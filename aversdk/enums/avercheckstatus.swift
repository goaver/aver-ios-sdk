//
//  avercheckstatus.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

enum AverCheckStatus: String, Decodable {
    case canceled = "Canceled"
    case created = "Created"
    case awaitingUser = "AwaitingUser"
    case awaitingAutomation = "AwaitingAutomation"
    case awaitingReview = "AwaitingReview"
    case inReview = "InReview"
    case rejected = "Rejected"
    case completed = "Completed"
}
