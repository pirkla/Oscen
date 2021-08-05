//
//  AppConfigController.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/2/21.
//

import Foundation
import SwiftUI


class AppConfigController: AppConfigControllerProto {
    
    private let configKey = "com.apple.configuration.managed"

    private var hooks = [() -> Void]()
    
    init() {
        // This one doesn't work, it gets fired too often and unpredicatably which can break things. Maybe separate answers and questions?
        // NotificationCenter.default.addObserver(self, selector: #selector(didChange), name: UserDefaults.didChangeNotification, object: nil)
        // for now lets just update the app if it gets brought to the foreground
        NotificationCenter.default.addObserver(self, selector: #selector(didChange), name: UIScene.willEnterForegroundNotification, object: nil)
    }
    
    // TODO: throw an error when required values are missing instead of providing placeholder values
    func readAppConfig() -> AppConfigModel? {
        if let managedConf = UserDefaults.standard.object(forKey: configKey) as? [String:Any?] {
            let webhookUrl = managedConf["webhook"] as? String ?? ""
            let title = managedConf["title"] as? String ?? ""
            let variables = managedConf["variables"] as? Dictionary<String,String> ?? Dictionary()
            let questions = managedConf["questions"] as? Array<Dictionary<String,Any>> ?? Array()
            return AppConfigModel(webhookUrl: webhookUrl,title:title, variableDict: variables, questionArray: questions)
        }
        return nil
    }

    @objc func didChange() {
        hooks.forEach { hook in
            hook()
        }
    }
    
    public func addHook(_ configChangedHook: @escaping () -> Void) {
        hooks.append(configChangedHook)
    }
}
