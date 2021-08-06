//
//  MockAppConfigController.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

class MockAppConfigController: AppConfigControllerProto {
    private let questionModel2 = QuestionModel(questionId: "howareyou", questionType: QuestionModel.QuestionType.textInput, questionText: "Did you see it though?", questionAnswers: Array(),inputAnswer: "")
    private let questionModel1 = QuestionModel(questionId: "one", questionType: QuestionModel.QuestionType.dropdown, questionText: "Look at that survey!", questionAnswers: ["I see it!","No","Yeah survey!"], inputAnswer: "")
    private let questionModel3 = QuestionModel(questionId: "color", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick a color", questionAnswers: ["blue","cat","green"], inputAnswer: "")
    private let questionModel4 = QuestionModel(questionId: "thoughts", questionType: QuestionModel.QuestionType.textInput, questionText: "Any additional thoughts?", questionAnswers: Array(),inputAnswer: "")
    private let questionModel5 = QuestionModel(questionId: "survey", questionType: QuestionModel.QuestionType.dropdown, questionText: "How would you rate this survey?", questionAnswers: ["10/10","100%","10"], inputAnswer: "")
    
    private var nextReadAppConfigReturns: [AppConfigModel?] = Array()
    
    func readAppConfig() -> AppConfigModel? {
        if (!nextReadAppConfigReturns.isEmpty) {
            return nextReadAppConfigReturns.removeFirst()
        }
        let questionArray = [questionModel1.asDictionary(), questionModel2.asDictionary()]
        let variables = ["username":"someuser","udid":"111111222222333334444","somevariable":"yeah we got this"]
        return AppConfigModel(webhookUrl: "https://badurl.asdf", title: "Survey!", variableDict: variables, questionArray: questionArray)
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
