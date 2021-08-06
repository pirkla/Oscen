//
//  ConfigTests.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

class ConfigTests {
    func setTestDefaults() {
        let questionModel1 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.textInput, questionText: "How are you?", questionAnswers: Array(),inputAnswer: "wackadoo2")
        let questionModel2 = QuestionModel(questionId: "2", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One", questionAnswers: ["one","two","three"], inputAnswer: "one2")
        let questionModel3 = QuestionModel(questionId: "4", questionType: QuestionModel.QuestionType.dropdown, questionText: "Choose a color", questionAnswers: ["blue","cat","green"], inputAnswer: "one2")
        
        
        let defaults = UserDefaults.standard
        defaults.set("https://enzs9uvxhj7j1n2.m.pipedream.net", forKey: "webhook")
        defaults.set("Question time buddy", forKey: "title")
        defaults.set([questionModel1.asDictionary(), questionModel2.asDictionary(), questionModel3.asDictionary()], forKey: "questions")
        defaults.set(["somevariable":"someusername","variable2":"someudid","variable3":"something else"], forKey: "variables")
    }

    func loadTestDefaults() -> AppConfigModel? {
        let defaults = UserDefaults.standard
        print("reading test defaults")
        guard let questions = defaults.object(forKey: "questions") as? Array<Dictionary<String,Any>> else {
            return nil
        }
        let variables = defaults.object(forKey: "variables") as? Dictionary<String,String> ?? Dictionary()
        let webhook = defaults.object(forKey: "webhook") as? String ?? ""
        let title = defaults.object(forKey: "title") as? String ?? ""
        return AppConfigModel(webhookUrl: webhook, title: title, variableDict: variables, questionArray: questions)

    }
}

