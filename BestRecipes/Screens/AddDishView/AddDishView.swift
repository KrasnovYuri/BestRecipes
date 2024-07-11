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
    @State var textPrint = false
    @Binding var tabBarIndex: Int
    var body: some View {
        NavigationView {
            VStack {
                ScrollView (.vertical, showsIndicators: false){
                    VStack {
                        //ImagePicker
                        ZStack {
                            Image("testImage")
                                .resizable()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .scaledToFill()
                            
                        }
//                        .frame(height: 200)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(title.count > 0 ? .brRed : .black)
                            
                            TextField("Enter dish name", text: $title)
                                .font(.custom(Font.regular, size: 14))
                                .padding(.horizontal, 10)
                            
                            
                        }.frame(height: 44)
                            .padding(.vertical, 10)
                        VStack {
                            AddDishElement(serves: true, value: $serves)
                            AddDishElement(serves: false, value: $cookTime)
                                .padding(.vertical, 5)
                        }
                        VStack {
                            HStack {
                                Text("Ingredients")
                                    .font(.custom(Font.semiBold, size: 20))
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            //                ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                if ingredients.count != 0 {
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
                                            .frame(width: 200)
                                            //                                        Spacer()
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundStyle(.brGray)
                                                TextField("amount", text: ingredient.amount)
                                                    .font(.custom(Font.regular, size: 14))
                                                    .padding(.horizontal, 10)
                                                    .textContentType(.telephoneNumber)
                                            }
                                            .frame(width: 70)
                                            
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
                                                .frame(width: 50)
                                                
                                            }
                                            Button {
                                                ingredients = ingredients.filter({ UserIngredient in
                                                    UserIngredient.id != ingredient.id
                                                })
                                            } label: {
                                                Image("minusButton")
                                            }
                                            
                                        }
                                        .frame(height: 45)
                                    }
                                }
                                Button {
                                    ingredients.append(UserIngredient())
                                } label: {
                                    HStack {
                                        Image("Plus")
                                        Text("Add new Ingredient")
                                            .font(.custom(Font.regular, size: 16))
                                            .foregroundStyle(.black)
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                        }
                        
                        
                    }
                    .frame(width: 370)
                    .animation(.easeInOut, value: ingredients.count)
                    
                    .onAppear {
                        modelData.tabBarHide = true
                    }
                    .onDisappear{
                        modelData.tabBarHide = false
                    }
                }
                Spacer()
                HStack {
                    Button {
                        //
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.brRed)
                            Text("Create recipe")
                                .font(.custom(Font.medium, size: 16))
                                .foregroundStyle(.white)
                        }
                        .frame(height: 56)
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Create recipe")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundColor(.black)
                                .lineLimit(2)
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                tabBarIndex = 0
                            } label: {
                                Image(.backButton)
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                }
                .padding(.horizontal, 16)
                
        }
    }
}

#Preview {
    AddDishView(modelData: ModelData(), tabBarIndex: .constant(2))
}
