//
//  AppConfigModel.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/1/21.
//

import Foundation

struct AppConfigModel {
    let webhookUrl: String
    let title: String
    let variableDict: Dictionary<String,String>
    let questionArray: Array<Dictionary<String,Any>>
}
