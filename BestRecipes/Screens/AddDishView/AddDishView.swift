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
            TextField(title, text: $title)
        }
    }
}

#Preview {
    AddDishView()
}
