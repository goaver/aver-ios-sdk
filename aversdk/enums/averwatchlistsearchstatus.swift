//
//  averwatchlistsearchstatus.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation


public enum AverWatchlistSearchStatus: String, Decodable
{
    case completed = "Completed"
    case failed = "Failed"
    case error = "Error"
}
