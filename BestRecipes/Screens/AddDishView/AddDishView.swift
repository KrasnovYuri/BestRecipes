//
//  AddDishView.swift
//  BestRecipes
//
//  Created by Руслан on 10.07.2024.
//

import SwiftUI

struct AddDishView: View {
    @StateObject var modelData: ModelData
    @State var title: String = ""
    @State var serves: Int = 0
    @State var cookTime: Int = 0
    @State var ingredients: [UserIngredient] = [UserIngredient()]
    @State var units = Unit.allCases.map {$0.rawValue}
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
            VStack {
                HStack {
                    Text("Ingredients")
                        .font(.custom(Font.semiBold, size: 20))
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach($ingredients, id: \.id) { ingredient in
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.brGray)
                                TextField("Item name", text: ingredient.title)
                                    .font(.custom(Font.regular, size: 14))
                                    .padding(.horizontal, 10)
                            }
                            .frame(width: 150)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.brGray)
                                TextField("amount", text: ingredient.amount)
                                    .font(.custom(Font.regular, size: 14))
                                    .padding(.horizontal, 10)
                            }
                            .frame(width: 70)
                            Spacer()
                            Button {
                                switch ingredient.wrappedValue.unit {
                                case "gr" : ingredient.wrappedValue.unit = "ml"
                                case "ml": ingredient.wrappedValue.unit = "sp"
                                case "sp": ingredient.wrappedValue.unit = "gr"
                                default : ingredient.wrappedValue.unit = "gr"
                                }
                                
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(.brGray)
                                    Text(ingredient.wrappedValue.unit)
                                        .foregroundStyle(.black)
                                        .font(.custom(Font.regular, size: 14))
                                        .padding(.horizontal, 10)
                                }
                                
                            }
                            Button {
                                
                            } label: {
                                ZStack {
                                    
                                }
                                
                            }
                            
                        }
                        .frame(height: 45)
                    }
                }
            }
            
            
        }
        .padding()
    }
}

#Preview {
    AddDishView(modelData: ModelData())
}
