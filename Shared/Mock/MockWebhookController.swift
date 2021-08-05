//
//  MockWebhookController.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

class MockWebhookController: WebhookControllerProto {
    
    private var nextPostSurveyResponses: [Result<Data, Error>] = Array()
    
    private let defaultResponse: Result<Data, Error> = .success("alls good here".data(using: .utf8)!)
    
    func postSurvey(surveySubmitModel: SurveySubmitModel, baseURL: URLComponents, session: URLSession, completion: @escaping (Result<Data, Error>) -> Void) {
        if (!nextPostSurveyResponses.isEmpty) {
            return completion(nextPostSurveyResponses.removeFirst())
        }
        return completion(defaultResponse)
    }
    
    
}
