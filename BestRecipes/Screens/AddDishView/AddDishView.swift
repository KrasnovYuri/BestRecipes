//
//  AddDishView.swift
//  BestRecipes
//
//  Created by Руслан on 10.07.2024.
//

import SwiftUI

struct AddDishView: View {
    @State var title: String = ""
    @State var serves: Int = 0
    @State var cookTime: Int = 0
    @State var ingredients: [Ingredient] = []
    var body: some View {
        VStack {
            //ImagePicker
            ZStack {
                RoundedRectangle(cornerRadius: 10)
            }
            .frame(height: 200)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.black)
                TextField(title, text: $title)
                    .font(.custom(Font.regular, size: 14))
                    .padding(.horizontal, 10)
            }.frame(height: 44)
            VStack {
                AddDishElement(serves: true, value: $serves)
                AddDishElement(serves: false, value: $cookTime)
            }
            
            
        }
        .padding()
    }
}

#Preview {
    AddDishView()
}
