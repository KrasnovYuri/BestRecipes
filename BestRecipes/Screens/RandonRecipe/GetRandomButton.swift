//
//  GetRandomButton.swift
//  BestRecipes
//
//  Created by Evgeniy K on 12.07.2024.
//

import SwiftUI

struct GetRandomButton: View {
    var text = "Get Random"
    var action = {}
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom(Font.bold, size: 24))
                .foregroundStyle(.white)
        }
        .frame(width: 270, height: 30)
        .padding(15)
        .background(.brRed)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    GetRandomButton()
}
