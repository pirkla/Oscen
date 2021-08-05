//
//  WebhookControllerProto.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

protocol WebhookControllerProto {
    func postSurvey(surveySubmitModel:SurveySubmitModel, baseURL: URLComponents, session: URLSession, completion: @escaping (Result<Data,Error>)-> Void)
}
