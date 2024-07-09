//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct RecipeDetailView: View {

    @StateObject var modelData: ModelData = ModelData()
    @State var id: Int
    @State var dish: RecipeDetails = RecipeDetails()
    @State var isSet: Bool = true
    @State var saved: Bool = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // title
                Text("How to make \(dish.title)")
                    .font(.custom(Font.semiBold, size: 24))
                    .padding(.horizontal, 6)

                // dish image
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
                        // TODO: - add logic to save element to fav
                        saved.toggle()
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
                       
                    
                    .padding(.trailing, 30)
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
            Spacer(minLength: 120)
            
        }
        .onAppear {
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
    }
    
}

#Preview {
    RecipeDetailView(id: 773242)
}
