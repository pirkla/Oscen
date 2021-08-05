//
//  AppConfigControllerProto.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

protocol AppConfigControllerProto {
    func readAppConfig() -> AppConfigModel?
    func addHook(_ configChangedHook: @escaping () -> Void)
}
