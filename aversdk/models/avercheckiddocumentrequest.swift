//
//  avercheckiddocumentrequest.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation

public struct AverCheckIdDocumentRequest {
    var docType: AverCheckDocumentType
    var side: AverCheckDocumentSide
    var fileName: String
    var fileContent: String
    var forceCommit: Bool = false
}
