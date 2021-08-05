//
//  SurveySubmitModel.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/1/21.
//

import Foundation

struct SurveySubmitModel: Codable {
    let variables: Dictionary<String,String>
    let answers: Dictionary<String,String>
}

extension SurveySubmitModel {
    init(variables: [String:String], questionModels: [QuestionModel]) {
        self.variables = variables
        var answerDict: Dictionary<String,String> = Dictionary()
        questionModels.forEach { question in
            answerDict[question.questionId] = question.inputAnswer
        }
        self.answers = answerDict
    }
    
    // TODO: don't do this like this
    func asJsonData() -> Data {
        let jsonEncoder = JSONEncoder()
        return try! jsonEncoder.encode(self)
    }
}
