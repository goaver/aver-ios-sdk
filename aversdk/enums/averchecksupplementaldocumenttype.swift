//
//  averchecksupplementaldocumenttype.swift
//  aversdk
//
//  Created by Gubanotorious on 6/2/21.
//

import Foundation

enum AverCheckSupplementalDocumentType: String, Decodable {
    case utilityBill = "UtilityBill"
    case taxDocument = "TaxDocument"
    case bankOrCreditCard = "BankOrCreditCard"
    case accreditedInvestor = "AccreditedInvestor"
    case medicalCard = "MedicalCard"
}
