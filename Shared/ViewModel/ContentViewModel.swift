//
//  ContentViewModel.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/1/21.
//

import Foundation
import SwiftUI


class ContentViewModel: ObservableObject{
    
    let appConfigController: AppConfigControllerProto
    let webhookController: WebhookControllerProto
    @Published var questions: [QuestionModel] = Array()
    @Published var title = ""
    var webhook = ""
    var variables = Dictionary<String,String>()
    
    @Published var showAlert = false
    var errorDetails: ErrorDetails? = nil

    func setAlert(shouldShow: Bool = true, _ details: ErrorDetails) {
        DispatchQueue.main.async {
            self.errorDetails = details
            self.showAlert = shouldShow
        }
    }
    
    init(appConfigController: AppConfigControllerProto = AppConfigController(),
         webhookController: WebhookControllerProto = WebhookController()) {
        self.appConfigController = appConfigController
        self.webhookController = webhookController
        self.loadAppConfig(appConfigController)
    }
    
    var canSubmit: Bool {
        get {
            for question in questions {
                if (question.inputAnswer.isEmpty) {
                    return false
                }
            }
            return true
        }
    }
    
    func publishWebhook() {
        if (!canSubmit) {
            self.setAlert(ErrorDetails(title: "Error", message: "Please fill in all answers.", buttonMessage: "Ok", buttonAction: nil))
            return
        }
        let surveySubmitModel = SurveySubmitModel(variables: variables, questionModels: questions)
        //TODO handle creating webhook url better
        webhookController.postSurvey(surveySubmitModel: surveySubmitModel, baseURL: URLComponents(string: webhook)!, session: URLSession.shared) {
            (result) in
            switch result {
            case .success(_):
                self.setAlert(ErrorDetails(title: "Success!", message: "Your answers have been submitted.", buttonMessage: "Do it again", buttonAction: nil))
            case .failure(let error):
                self.setAlert(ErrorDetails(title: "Error", message: error.localizedDescription + ". Contact your admin for help.", buttonMessage: "Retry", buttonAction: nil))
            }
        }
    }
    
    //TODO: clean this up
    func loadAppConfig(_ appConfigController: AppConfigControllerProto) {
        guard let appConfigModel = appConfigController.readAppConfig() else {
            let details = ErrorDetails(title: "Error", message: "No app configuration found. Contact your admin for help.", buttonMessage: "Retry") {
                self.loadAppConfig(appConfigController)
            }
            setAlert(details)
            return
        }
        questions = QuestionModel.fromDict(questionArray: appConfigModel.questionArray)
        webhook = appConfigModel.webhookUrl
        variables = appConfigModel.variableDict
        title = appConfigModel.title
        
        guard !webhook.isEmpty else {
            // TODO:
            let details = ErrorDetails(title: "Error", message: "No webhook found. Contact your admin for help.", buttonMessage: "Retry") {
                self.loadAppConfig(appConfigController)
            }
            setAlert(details)
            return
        }
        
        guard !questions.isEmpty else {
            //TODO:
            let details = ErrorDetails(title: "Error", message: "No question configurations found. Contact your admin for help.", buttonMessage: "Retry") {
                self.loadAppConfig(appConfigController)
            }
            setAlert(details)
            return
        }
    }
}
