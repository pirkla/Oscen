//
//  WebhookController.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/4/21.
//

import Foundation

class WebhookController: WebhookControllerProto {
    func postSurvey(surveySubmitModel:SurveySubmitModel, baseURL: URLComponents, session: URLSession, completion: @escaping (Result<Data,Error>)-> Void) {
        guard let myUrl = baseURL.url else {
            completion(.failure(NSError()))
            return
        }
        
        let myRequest = URLRequest(url: myUrl, method: HTTPMethod.post,dataToSubmit: surveySubmitModel.asJsonData(), contentType: .json)
        session.dataTask(request: myRequest) {
            (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }.resume()
        return
    }
}
