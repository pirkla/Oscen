//
//  MockAppConfigController.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

class MockAppConfigController: AppConfigControllerProto {
    private let questionModel1 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.textInput, questionText: "How are you?", questionAnswers: Array(),inputAnswer: "")
    private let questionModel2 = QuestionModel(questionId: "2", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One", questionAnswers: ["one","two","three"], inputAnswer: "")
    private let questionModel3 = QuestionModel(questionId: "4", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One", questionAnswers: ["one12123","two123","three123"], inputAnswer: "")
    
    private var nextReadAppConfigReturns: [AppConfigModel?] = Array()
    
    func readAppConfig() -> AppConfigModel? {
        if (!nextReadAppConfigReturns.isEmpty) {
            return nextReadAppConfigReturns.removeFirst()
        }
        let questionArray = [questionModel1.asDictionary(), questionModel2.asDictionary(), questionModel3.asDictionary()]
        let variables = ["username":"someuser","udid":"111111222222333334444","somevariable":"yeah we got this"]
        return AppConfigModel(webhookUrl: "https://example.com", title: "Some questions for you friend", variableDict: variables, questionArray: questionArray)
    }
    
    func addHook(_ configChangedHook: @escaping () -> Void) {
        return
    }
    
    func addReadAppConfigReturns(appConfigModels: [AppConfigModel?]) {
        nextReadAppConfigReturns += appConfigModels
    }
    
    func setReadAppConfigReturns(appConfigModels: [AppConfigModel?]) {
        nextReadAppConfigReturns = appConfigModels
    }
}
