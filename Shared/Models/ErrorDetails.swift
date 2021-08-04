//
//  ErrorDetails.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

struct ErrorDetails {
    let title: String
    let message: String
    let buttonMessage: String
    let buttonAction: (()->Void)?
}
