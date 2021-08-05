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
        ScrollView {
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
        .alert(isPresented:$contentViewModel.showAlert) {
            Alert(
                title: Text(contentViewModel.errorDetails?.title ?? "Error"),
                message: Text(contentViewModel.errorDetails?.message ?? "Unknown"),
                dismissButton: .default(Text(contentViewModel.errorDetails?.buttonMessage ?? "Ok")) {
                    contentViewModel.errorDetails?.buttonAction?()
                }            )
        }
        .frame(minWidth: 200, idealWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init("Background"))
        //TODO: add refreshable modifier in iOS 15
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {    
        let contentViewModel = ContentViewModel(appConfigController: MockAppConfigController())
        
        Group {
            ContentView(contentViewModel: contentViewModel).preferredColorScheme(.dark)
            ContentView(contentViewModel: contentViewModel).preferredColorScheme(.light)
        }
    }
}
