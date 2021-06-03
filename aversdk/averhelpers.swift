//
//  UIImage.swift
//  aversdk
//
//  Created by Gubanotorious on 6/3/21.
//

import Foundation
import UIKit

public class AverHelpers {
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}

