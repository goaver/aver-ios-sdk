//
//  averwatchlistsearchrecheckinterval.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public enum AverWatchlistSearchRecheckInterval: Int, Decodable
{
    case none = 0
    case daily = 1
    case weekly = 7
    case monthly = 30
    case quarterly = 90
}
