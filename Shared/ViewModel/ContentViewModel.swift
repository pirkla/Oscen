//
//  ContentViewModel.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/1/21.
//

import Foundation
import SwiftUI


class ContentViewModel: ObservableObject{
    
    let appConfigController: AppConfigController
    @Published var questions: [QuestionModel] = Array()
    @Published var title = ""
    var webhook = ""
    var variables = Dictionary<String,String>()
    
    
    @Published var showSheet = false
    var errorDescription = ""
    
    enum ActiveSheet {
        case errorView
        case successView
        case incompleteView
    }
    
    var activeSheet: ActiveSheet = .errorView {
        willSet {
            DispatchQueue.main.async {
                self.showSheet = true
            }
        }
    }
        
    init(questions: [QuestionModel]? = nil, appConfigController: AppConfigController? = nil) {
        self.questions = questions ?? Array()
        self.appConfigController = appConfigController ?? AppConfigController()
        self.appConfigController.addHook {
            self.loadAppConfig(self.appConfigController)
        }
        self.loadAppConfig(self.appConfigController)
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
            activeSheet = .incompleteView
            showSheet = true
            return
        }
        let surveySubmitModel = SurveySubmitModel(variables: variables, questionModels: questions)
        surveySubmitModel.postSurvey(baseURL: URLComponents(string: webhook)!, session: URLSession.shared) {
            (result) in
            switch result {
            case .success(_):
                self.activeSheet = .successView
            case .failure(let error):
                self.errorDescription = error.localizedDescription + ". Contact your admin for help."
                self.activeSheet = .errorView
            }
        }
    }
    
    func loadAppConfig(_ appConfigController: AppConfigController) {
        guard let appConfigModel = appConfigController.readAppConfig() else {
            errorDescription = "No app configuration found. Contact your admin for help."
            activeSheet = .errorView
            showSheet = true
            return
        }
        questions = QuestionModel.fromDict(questionArray: appConfigModel.questionArray)
        webhook = appConfigModel.webhookUrl
        variables = appConfigModel.variableDict
        title = appConfigModel.title
        
        guard !webhook.isEmpty else {
            errorDescription = "No webhook found. Contact your admin for help."
            activeSheet = .errorView
            return
        }
        
        guard !questions.isEmpty else {
            errorDescription = "No questions found. Contact your admin for help."
            activeSheet = .errorView
            return
        }
    }
    
    func currentModal() -> AnyView {
        switch activeSheet {
        case .errorView:
            return AnyView(InfoSheetView(title: "An error occurred", description: self.errorDescription, buttonTitle: "Retry", image: Image(systemName: "exclamationmark.octagon.fill")){
                self.loadAppConfig(self.appConfigController)
            })
        case .successView:
            return AnyView(InfoSheetView(title: "Success!", description: "Your answers have been submitted.", buttonTitle: "Do it again", image: nil, hook: nil))
        case .incompleteView:
            return AnyView(InfoSheetView(title: "Form is incomplete", description: "Complete all fields in the form before submitting.", buttonTitle: "Resume", image: nil, hook: nil))

        }
        
    }
}
