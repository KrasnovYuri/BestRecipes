//
//  BackButton.swift
//  BestRecipes
//
//  Created by Юрий on 08.07.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(.backButton)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    BackButton()
}
