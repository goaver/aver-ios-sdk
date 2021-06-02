//
//  avermodels.swift
//  aversdk
//
//  Created by Gubanotorious on 5/28/21.
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

public enum AverCheckStatusReason{
    case MissingDocuments
    case UnreadableDocumentsOrMissingVerificationInformation
    case ExpiredDocuments
    case SuspiciousDocumentsOrImages
    case FacialVerificationFailed
    case UnderageApplicant
}

public enum AverCheckType {
    case EmailVerification
    case DocumentVerification
    case PhotoVerification
    case AccreditedInvestor
    case Watchlist
    case VisualWatchlist
    case RiskProfiling
    case AddressVerification
}

public enum AverCheckWarning {
    case Country
    case State
    case IPVpnTor
    case Address
    case EmailAddress
    case WatchlistHitsFound
    case AdverseMediaFound
    case SameEmailFound
    case SameIdDocumentFound
    case SameNameFound
}

public enum AverCheckDocumentType{
    case CamPhoto
    case PassportImage
    case NADriverLicense
    case GenericIdentificationCardImage
}

public enum AverCheckDocumentSide{
    case None
    case Front
    case Back
}

public enum AverCheckSupplementalDocumentType{
    case UtilityBill
    case TaxDocument
    case BankOrCreditCard
    case AccreditedInvestor
    case MedicalCard
}

public struct AverAuthResponse : Decodable {
    var token: String
}

public struct AverCheckCreateRequest {
    var groupId: String
    var thirdPartyIdentifier: String
    var email: String
    var returnUrl: String = ""
    var language: String = "en"
    var skipPersonalAccessCode: Bool = false
    var overrideThirdPartyIdentifier: Bool = false
}

public struct AverCheckCreateResponse : Decodable {
    var checkId: String?
    var thirdPartyIdentifier: String?
    var url: String?
}

public struct AverCheckDetailResponse: Decodable {
    var id: String?
    var groupId: String?
    var thirdPartyIdentifier: String?
    var status: String?
    var checkTypes: [String]?
    var checkResults: AverCheckResults?
    var warnings: [String]?
}

public struct AverCheckAccessLinkResponse: Decodable {
    var url: String?
}

public struct AverCheckResults: Decodable {
    var watchlistSearchId: String?
    var attestations: AverCheckAttestations?
    var personalInformation: AverCheckPersonalInformation?
    var identificationDocument: AverCheckIdentificationDocument?
    var photoVerification: AverCheckPhotoVerification?
    var addressVerification: AverCheckAddressVerification?
    var riskProfile: AverCheckRiskProfile?
    var warnings: [String]?
}

public struct AverCheckAttestations: Decodable {
    var accreditedInvestor: Bool?
    var over18: Bool?
    var over21: Bool?
}

public struct AverCheckPersonalInformation: Decodable {
    var email: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var gender: String?
    var dateOfBirth: String?
    var stateProvince: String?
    var country: String?
}

public struct AverCheckIdentificationDocument: Decodable {
    var type: String?
    var frontId: String?
    var backId: String?
    var expirationDate: String?
    var documentNumber: String?
}

public struct AverCheckPhotoVerification: Decodable {
    var id: String?
    var type: String?
}

public struct AverCheckAddressVerification: Decodable {
    var validAddress: Bool?
    var reportedFraud: Bool?
    var streetAddress1: String?
    var streetAddress2: String?
    var city: String?
    var stateOrProvince: String?
    var postalCode: String?
    var country: String?
}

public struct AverCheckRiskProfile: Decodable {
    var facialMatchConfidence: Int?
    var ipAndDeviceAnalysisResults: AverCheckIpAnalysisResults?
    var emialAnalysisResults: AverEmailAnalysisResults?
}

public struct AverCheckIpAnalysisResults: Decodable {
    var vpnOrTor: Bool?
    var ip: String?
    var fraudScore: String?
    var recentAbuse: Bool?
    var isp: String?
    var host: String?
    var timezone: String?
    var localTime: String?
    var position: Double?
    var country: String?
    var city: String?
    var state: String?
    var operatingSystem: String?
    var browser: String?
    var deviceBrand: String?
    var deviceModel: String?
}

public struct AverEmailAnalysisResults: Decodable {
    var overallScore: Int?
    var suspect: Bool?
    var validAddress: Bool?
    var temporaryDisposable: Bool?
    var catchAllShared: Bool?
    var honeyPotSpamTrap: Bool?
    var recentAbuse: Bool?
    var commonProvider: Bool?
    var deliverability: Bool?
    var validDNSConfig: Bool?
    var smtpConfigScore: Int?
    var frequentComplainer: Bool?
}
