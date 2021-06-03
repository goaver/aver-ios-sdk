//
//  averwatchlistsearchcategory.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

enum AverWatchlistSearchCategory: String, Decodable {
    case criminal = "Criminal"
    case terrorism = "Terrorism"
    case financial = "Financial"
    case financialNotices = "FinancialNotices"
    case political = "Political"
    case medical = "Medical"
    case sexual = "Sexual"
    case gambling = "Gambling"
    case education = "Education"
}
