//
//  avercheckstatus.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

public enum AverCheckStatus {
    case Canceled
    case Created
    case AwaitingUser
    case AwaitingAutomation
    case AwaitingReview
    case InReview
    case Rejected
    case Completed
}
