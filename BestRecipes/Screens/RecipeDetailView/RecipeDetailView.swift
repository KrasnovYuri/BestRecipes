//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @StateObject var modelData: ModelData
    let service = NetworkServiceAA()
    let disappearIsOn: Bool
    @State var id: Int
    @State var dish: RecipeDetails = RecipeDetails()
    @State var isSet: Bool = true
    @State var saved: Bool = false
    @State var delete: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer(minLength: 20)
                    ZStack {
                        
                        AsyncImage(url: URL(string: dish.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 343, maxHeight: 200)
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 6)
                        HStack {
                            Spacer()
                            VStack {
                                
                                ZStack {
                                    Circle()
                                        .frame(width: 35)
                                        .foregroundStyle(.white.opacity(0.6))
                                    
                                    Circle()
                                        .stroke()
                                        .foregroundStyle(saved ? .brRed : .brGray)
                                        .frame(width: 35)
                                    
                                    Image(saved ? "TabBarBookmarkActive" : "TabBarBookmarkInactive")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 22, height: 22)
                                        .padding(17)
                                }
                                Spacer()
                            }
                            
                        }
                        .frame(maxWidth: 343, maxHeight: 200)
                    }
                    // rating
                    HStack {
                        HStack {
                            RatingElement(bg: false, rating: dish.spoonacularScore)
                            Text("(\(dish.weightWatcherSmartPoints * 10) Reviews)")
                                .font(.custom(Font.light, size: 14))
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        // save recipe
                        //                    HStack {
                        Button {
                            modelData.saveToFavorite(id: id)
                            saved = true
                            
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(saved ? .brRed : .brNeutral )
                                    HStack {
                                        
                                        Text(saved ? "Saved" : "Save it?" )
                                            .foregroundStyle(saved ? .white : .black )
                                            .font(.custom(Font.regular, size: 14))
                                            .lineLimit(1)
                                    }
                                }
                                .frame(width: 80)
                            }
                        }
                        .disabled(saved)
                        .padding(.trailing, !saved ? 30 : 0)
                        if saved {
                            Button {
                                delete = true
                            } label : {
                                Image(systemName: "trash.fill")
                                    .foregroundStyle(saved ? .brRed : .brNeutral )
                            }
                            .padding(.trailing, saved ? 30 : 0)
                        }
                        
                    }
                    .padding(.leading, 15)
                    
                    // instructions
                    VStack(alignment: .leading, spacing: 2) {
                        if let instructions = dish.analyzedInstructions, !instructions.isEmpty {
                            let nonEmptyInstructions = instructions.filter { !$0.steps.isEmpty }
                            if !nonEmptyInstructions.isEmpty {
                                Text("Instructions")
                                    .font(.custom(Font.semiBold, size: 20))
                                    .padding(.vertical, 6)
                                
                                ForEach(instructions, id: \.name) { instruction in
                                    ForEach(instruction.steps, id: \.number) { step in
                                        HStack(alignment: .top) {
                                            Text("\(step.number).")
                                                .frame(width: 13)
                                            Text(step.step)
                                            Spacer()
                                        }
                                        .font(.custom(Font.light, size: 16))
                                        .frame(width: 328)
                                    }
                                }
                                .padding(.horizontal, 6)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Ingredients")
                            .font(.custom(Font.semiBold, size: 20))
                            .padding(.top, 15)
                            .padding(.bottom, 6)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        ForEach(dish.extendedIngredients, id: \.id) { ingredient in
                            IngridientComponentView(ingridient: ingredient)
                        }
                    }
                }
                .blur(radius: delete ? 20 : 0)
                Spacer(minLength: 30)
                
            }
            
            
            if delete {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .shadow(radius: 10)
                        .foregroundStyle(.white)
                    VStack {
                        Text("Delete from favorite?")
                            .multilineTextAlignment(.center)
                            .font(.custom(Font.semiBold, size: 18))
//                            .padding(10)
                            .padding(.top, 20)
                            .frame(height: 50)
                        HStack {
                            Button {
                                modelData.deleteFromFavorite(id: id)
                                saved = false
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
//                                    Text("Yes")
//                                        .font(.custom(Font.bold, size: 18))
//                                        .foregroundStyle(.brRed)
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
//                                    Text("No")
//                                        .font(.custom(Font.bold, size: 18))
//                                        .foregroundStyle(.black)
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
        // animation
        .animation(.easeInOut, value: saved)
        .animation(.easeInOut, value: delete)
        // onAppear and disappear
        .onAppear {
            modelData.tabBarHide = true
            modelData.saveRecent(id: id)
            modelData.loadRecentDishes()
            
            saved = modelData.checkFavorite(id: id)
            Task {
                do {
                    dish = try await service.getDishById(id: id)
                } catch {
                    
                }
            }
        }
        .onDisappear{
            if disappearIsOn {
                modelData.tabBarHide = false
            }
        }
        //navigation settings and toolbar
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(dish.title)
                    .font(.custom(Font.semiBold, size: dish.title.count > 10 ? 18 : 24))
                    .foregroundColor(.black)
                    .lineLimit(2)
            }
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
    }
    
}

#Preview {
    RecipeDetailView(modelData: ModelData(), disappearIsOn: true, id: 773242)
}
