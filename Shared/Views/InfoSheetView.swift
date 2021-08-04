//
//  ErrorView.swift
//  wiperator
//
//  Created by Andrew Pirkl on 5/27/20.
//  Copyright © 2020 Pirklator. All rights reserved.
//

import SwiftUI

struct InfoSheetView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: String
    let description: String
    let buttonTitle: String
    let image: Image?
    let hook: (() -> Void)?
    
    var body: some View {
      HStack {
        VStack {
            HStack{
            Text(title)
                .font(.system(size: 20))
                if let image=image {
                    image
                        .resizable()
                        .frame(width: 20.0, height: 20)
                }
                
            }
            .padding(.all, 10)
            Text(description)
                .padding(.all, 20.0)
                .multilineTextAlignment(.center)
            Button(action: {
                hook?()
                self.presentationMode.wrappedValue.dismiss()
            }) {
              Text(buttonTitle)
            }
            .padding(.all, 10.0)
        }
      }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheetView(title: "Preview", description: "Description Preview", buttonTitle: "Dismiss", image: Image(systemName: "exclamationmark.octagon.fill"), hook: nil)
    }
}
