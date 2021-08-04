//
//  AppConfigController.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/2/21.
//

import Foundation


class AppConfigController {
    
    private let configKey = "com.apple.configuration.managed"

    private var hooks = [() -> Void]()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    // TODO: throw an error when required values are missing instead of providing placeholder values
    func readAppConfig() -> AppConfigModel? {
//        setTestDefaults()
//        return loadTestDefaults()
        if let managedConf = UserDefaults.standard.object(forKey: configKey) as? [String:Any?] {
            let webhookUrl = managedConf["webhook"] as? String ?? ""
            let title = managedConf["title"] as? String ?? ""
            let udid = managedConf["udid"] as? String
            let username = managedConf["username"] as? String
            let questions = managedConf["questions"] as? Array<Dictionary<String,Any>> ?? Array()
            return AppConfigModel(webhookUrl: webhookUrl,title:title, udid: udid, username: username, questionArray: questions)
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
    
    
    func setTestDefaults() {
        let questionModel1 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.textInput, questionText: "How are you?", questionAnswers: Array(),inputAnswer: "wackadoo2")
        let questionModel2 = QuestionModel(questionId: "2", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One", questionAnswers: ["one","two","three"], inputAnswer: "one2")
        let questionModel3 = QuestionModel(questionId: "4", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One", questionAnswers: ["one12123","two123","three123"], inputAnswer: "one2")
        
        
        let defaults = UserDefaults.standard
        defaults.set("https://enzs9uvxhj7j1n2.m.pipedream.net", forKey: "webhook")
        defaults.set("Question time hot dog", forKey: "title")
        defaults.set("0001111122222", forKey: "udid")
        defaults.set("big boi", forKey: "username")
        defaults.set([questionModel1.asDictionary(), questionModel2.asDictionary(), questionModel3.asDictionary()], forKey: "questions")
        defaults.set(["variable1":"someusername","variable2":"someudid","variable3":"something else"], forKey: "variables")
    }
    
    func loadTestDefaults() -> AppConfigModel? {
        let defaults = UserDefaults.standard
        print("reading test defaults")
        guard let questions = defaults.object(forKey: "questions") as? Array<Dictionary<String,Any>> else {
            return nil
        }
        let webhook = defaults.object(forKey: "webhook") as? String ?? ""
        let udid = defaults.object(forKey: "udid") as? String ?? ""
        let username = defaults.object(forKey: "username") as? String ?? ""
        let title = defaults.object(forKey: "title") as? String ?? ""
        return AppConfigModel(webhookUrl: webhook, title: title, udid: udid, username: username, questionArray: questions)

    }
    
}
