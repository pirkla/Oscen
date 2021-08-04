//
//  ContentView.swift
//  Shared
//
//  Created by Andrew Pirkl on 8/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @State var animate = false
    var body: some View {
        VStack {
            HStack {
                Text(contentViewModel.title)
                    .padding()
            }.drawingGroup()
            VStack{
                ForEach(contentViewModel.questions.indices, id: \.self) { index in
                    QuestionView(question: $contentViewModel.questions[index])
                    Divider()
                        .background(Color.init("Background"))
                        .padding(.leading, 20.0)
                }
            }.background(Color.init("MiscBackground"))
            Button(action: {
                self.contentViewModel.publishWebhook()
            }) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.init("MiscBackground"))
            }
            #if !targetEnvironment(macCatalyst)
            Spacer()
            #endif
        }
        .sheet(isPresented: $contentViewModel.showSheet) {
            self.contentViewModel.currentModal()
        }
        .frame(minWidth: 200, idealWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init("Background"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let questionModel1 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.textInput, questionText: "How many times would you say?", questionAnswers: Array(),inputAnswer: "wackadoo")
        let questionModel2 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.dropdown, questionText: "But how are you really?", questionAnswers: ["one","two","three"], inputAnswer: "one")
        
        let questionArray = [questionModel1, questionModel2, questionModel1, questionModel2,questionModel2]
    
        let contentViewModel = ContentViewModel(questions:questionArray)
        
        Group {
            ContentView(contentViewModel: contentViewModel).preferredColorScheme(.dark)
            ContentView(contentViewModel: contentViewModel).preferredColorScheme(.light)
        }
    }
}
