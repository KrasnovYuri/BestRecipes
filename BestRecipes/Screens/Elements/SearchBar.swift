//
//  SearchBar.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI


struct SearchBar: View {
    
    @State var searchRecipe = ""
    
    var body: some View {
        HStack {
            Image(.search)
            
            TextField("Search recipes", text: $searchRecipe)
                .font(.custom(Font.regular, fixedSize: 16))
            
            if !searchRecipe.isEmpty {
                Button {
                    searchRecipe = ""
                } label: {
                    Image(.plus)
                        .rotationEffect(.degrees(45))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(searchRecipe.isEmpty ? Color(.brGray) : Color(.brRed))
        )
        .padding()
    }
}

#Preview {
    SearchBar()
}

