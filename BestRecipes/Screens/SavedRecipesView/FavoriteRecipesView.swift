//
//  SavedRecipesView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct FavoriteRecipesView: View {
    @StateObject var modelData: ModelData
    @State var delete = false
    @State var deleteId: Int = 0
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Favorite recipes")
                            .lineLimit(2)
                            .font(.custom(Font.bold, size: 24))
                        Spacer()
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(modelData.favoriteDishes, id: \.id ) { dish in
                            NavigationLink {
                                RecipeDetailView(modelData: modelData, disappearIsOn: true, id: dish.id)
                            } label: {
                                ZStack {
                                    TrendingDishElement(bigSize: true, dish: dish)
                                        .padding(.vertical, 12)
                                    VStack {
                                        HStack {
                                            RatingElement(bg: true, rating: dish.spoonacularScore)
                                            Spacer()
                                            Button {
                                                delete = true
                                                deleteId = dish.id
                                            } label: {
                                                ZStack {
                                                    Circle()
                                                        .foregroundStyle(.white)
                                                    Image(systemName: "trash.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 18)
                                                        .foregroundStyle(.brRed)
                                                }
                                                .frame(width: 32, height: 32)
                                            }
                                            
                                        }
                                        .padding(.horizontal, 15)
                                        .padding(5)
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                            
                            
                        }
                    }
                }
                .padding(10)
                .blur(radius: delete ? 20 : 0 )
                if delete {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .shadow(radius: 10)
                            .foregroundStyle(.white)
                        VStack {
                            Text("Delete from favorite?")
                                .multilineTextAlignment(.center)
                                .font(.custom(Font.semiBold, size: 18))
                                .padding(.top, 20)
                                .frame(height: 50)
                            HStack {
                                Button {
                                    modelData.deleteFromFavorite(id: deleteId)
                                    delete = false
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 0.3)
                                            .foregroundStyle(.brRed)
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.brRed)
                                            .scaleEffect(0.8)
                                    }
                                }
                                .frame(width: 100, height: 50)
                                
                                Button { delete = false } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 0.3)
                                            .foregroundStyle(.black)
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.black)
                                            .scaleEffect(0.8)
                                    }
                                }
                                .frame(width: 100, height: 50)
                            }
                            .padding()
                        }
                        
                    }
                    .frame(width: 300, height: 150)
                }
            }
            //animation
            .animation(.easeInOut, value: delete)
        }
    }
}

#Preview {
    FavoriteRecipesView(modelData: ModelData())
}
