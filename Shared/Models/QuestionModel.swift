//
//  QuestionModel.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/2/21.
//

import Foundation

struct QuestionModel: Hashable, Codable {
    let questionId: String
    let questionType: QuestionType
    let questionText: String
    let questionAnswers: Array<String>
    var inputAnswer: String = ""
    
    enum QuestionType: String, Codable {
        case dropdown
        case textInput
    }
}

extension QuestionModel {
    func asDictionary() -> Dictionary<String,Any> {
        return ["questionId":questionId,
                "questionType": questionType.rawValue,
                "questionText": questionText,
                "questionAnswers":questionAnswers]
    }
    
    static func fromDict(questionArray:Array<Dictionary<String,Any>>) -> [QuestionModel] {
        var resultModels: [QuestionModel] = Array()
        questionArray.forEach { subDict in
            resultModels.append(QuestionModel(questionId: subDict["questionId"] as? String ?? "Unknown",
                                               questionType: QuestionType.init(rawValue: subDict["questionType"] as? String ?? "") ?? QuestionType.textInput,
                                               questionText: subDict["questionText"] as? String ?? "Unknown",
                                               questionAnswers: subDict["questionAnswers"] as? Array<String> ?? Array())
            )
        }
        return resultModels
    }
}
