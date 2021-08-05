//
//  QuestionView.swift
//  Oscen
//
//  Created by Andrew Pirkl on 8/1/21.
//

import SwiftUI

struct CustomPickerLabel : View {
    let title: String
    @Binding var boundAnswer: String
    
    var body: some View {
        HStack{
            Text(title)
            TextField("Select One", text: $boundAnswer)
                .allowsHitTesting(false)
                .multilineTextAlignment(.center)
        }
    }
}

struct QuestionView: View {
    
    @Binding var question: QuestionModel
        
    var body: some View {
        if (question.questionType == QuestionModel.QuestionType.dropdown) {
            HStack{
                Picker(selection: $question.inputAnswer, label: CustomPickerLabel(title: question.questionText, boundAnswer: $question.inputAnswer) ) {
                    ForEach(question.questionAnswers, id: \.self) {
                        Text($0)
                            .multilineTextAlignment(.leading)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
            }
            .padding(.leading, 12)
        }
        else {
            VStack{
                Text(question.questionText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading, .trailing], 12)
                VStack(alignment:.center){
                    TextField("Answer", text: $question.inputAnswer)
                        .frame(maxWidth: .infinity)
                        
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.init("TextBackground"))
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let questionModel1 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.textInput, questionText: "How are you?", questionAnswers: Array(),inputAnswer: "")
        let questionModel2 = QuestionModel(questionId: "2", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One", questionAnswers: ["one","two","three","four","five","six","seven"], inputAnswer: "")
        let questionModel3 = QuestionModel(questionId: "1", questionType: QuestionModel.QuestionType.textInput, questionText: "How are you? Here is some extra stuff to see what happens when I put in a lot of extra text", questionAnswers: Array(),inputAnswer: "wackadoo")
        let questionModel4 = QuestionModel(questionId: "2", questionType: QuestionModel.QuestionType.dropdown, questionText: "Pick One plus some extra text to see how this gets handled", questionAnswers: ["one and a lot of extra texts how will it handle all this extra text can it even do it probably not  ","two","three","four","five","six","seven"], inputAnswer: "one")
        VStack(alignment: .leading) {
            QuestionView(question: .constant(questionModel1))
            QuestionView(question: .constant(questionModel2))
            QuestionView(question: .constant(questionModel3))
            QuestionView(question: .constant(questionModel4))

        }

    }
}
