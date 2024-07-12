//
//  HomeView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct HomeView: View {
    @State var index = 1
    @State var userSearch = ""
    @State var userChoiseCourse = "Main Course"
    @Binding var searchEnable: Bool
    @StateObject var modelData: ModelData
    var body: some View {
        NavigationView {
     
            ScrollView(.vertical) {
                //                header
                HStack {
                    Text("Get amazing recipes for cooking")
                        .lineLimit(2)
                        .font(.custom(Font.bold, size: 24))
                    Spacer()
                }
                .padding(.horizontal, 16)
                //                 search
                SearchView(modelData: modelData, active: $searchEnable)
                if !searchEnable {
                    VStack {
                        HStack{
                            HStack {
                                Text("Trending now 🔥")
                                    .font(.custom(Font.medium, size: 20))
                            }
                            Spacer()
                            HStack {
                                NavigationLink {
                                    DishesListView(modelData: modelData, dishesList: modelData.trendingDishes, textHeader: "Trending now")
                                } label: {
                                    Text("See all")
                                        .font(.custom(Font.medium, size: 14))
                                        .foregroundStyle(.brRed)
                                    Image(systemName: "arrow.right")
                                        .foregroundStyle(.brBlack)
                                }
                                
                                
                            }
                        }
                        .padding(.horizontal, 16)
                        //Scroll view
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach( modelData.trendingDishes, id: \.id) { dish in
                                    NavigationLink(destination: RecipeDetailView(modelData: modelData, id: dish.id )) {
                                        ZStack {
                                            TrendingDishElement(bigSize: false, dish: dish)
                                            VStack {
                                                HStack {
                                                    RatingElement(bg: true, rating: dish.spoonacularScore)
                                                    Spacer()
                                                    FavoriteElement(checkFavorite: modelData.checkFavorite(id: dish.id))
                                                }
                                                .padding(12)
                                                Spacer()
                                            }
                                        }
                                        .padding(.leading, 16)
                                        
                                    }
                                }
                            }
                        }
                        
                        .frame(height: 280)
                    }
                    //Popular category
                    VStack {
                        HStack{
                            Text("Popular category")
                                .font(.custom(Font.medium, size: 20))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        //Food category
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(modelData.foodCategoryArray, id: \.self) { course in
                                    Button {
                                        userChoiseCourse = course
                                        modelData.fetchDishByFoodCategory(course)
                                    } label : {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(height: 34)
                                                .foregroundStyle( userChoiseCourse != course ? .white : .brRed)
                                            Text(course.lowercased().localizedCapitalized)
                                                .font(.custom(Font.medium, size: 12))
                                                .padding(5)
                                                .padding(.horizontal, 5)
                                                .foregroundStyle(( userChoiseCourse == course ? .white : .brRed))
                                        }
                                        .padding(.leading, modelData.foodCategoryArray[0] == course ? 16 : 0)
                                        
                                    }
                                }
                            }
                        }
                        // Popular dish list
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(modelData.foodCategoryPopularDishes, id: \.id) { dish in
                                    NavigationLink{
                                        RecipeDetailView(modelData: modelData, id: dish.id)
                                    } label: {
                                        ZStack {
                                            CategoryDishElement(dish: dish)
                                            HStack {
                                                Spacer()
                                                VStack{
                                                    Spacer()
                                                    FavoriteElement(checkFavorite: modelData.checkFavorite(id: dish.id))
                                                        .padding(10)
                                                    
                                                }
                                            }
                                            .padding(.leading, 16)
                                            .padding(.top, 5)
                                        }
                                        .padding(.leading, modelData.foodCategoryPopularDishes[0].id == dish.id ? 16 : 0)
                                    }
                                }
                            }
                            
                        }
                        .ignoresSafeArea()

                    }
                    //Recent View
                    VStack {
                        HStack {
                            HStack {
                                Text("Recent recipe")
                                    .font(.custom(Font.medium, size: 20))
                            }
                            Spacer()
                            HStack {
                                NavigationLink {
                                    DishesListView(modelData: modelData, dishesList: modelData.recentDishes, textHeader: "Recent dishes")
                                    //RecentListView(modelData: modelData.recentDishes, textHeader: "Recent dishes")
                                } label: {
                                    Text("See all")
                                        .font(.custom(Font.medium, size: 14))
                                        .foregroundStyle(.brRed)
                                    Image(systemName: "arrow.right")
                                        .foregroundStyle(.brBlack)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack {
                                ForEach(modelData.recentDishes, id: \.id) { dish in
                                    NavigationLink(destination: RecipeDetailView(modelData: modelData, id: dish.id)) {
                                        RecentDishElement(dish: dish)
                                            .padding(.leading, modelData.recentDishes[0].id == dish.id ? 16 : 0)
                                    }
                                }
                            }
                        }
                        .frame(height: 180)
                    }
                    //Kitchen list
                    VStack{
                        HStack {
                            HStack {
                                Text("Popular cuisines")
                                    .font(.custom(Font.medium, size: 20))
                            }
                            Spacer()
                            HStack {
                                NavigationLink {
                                    CuisineAllListView(modelData: modelData, textHeader: "Cuisines")
                                } label: {
                                    Text("See all")
                                        .font(.custom(Font.medium, size: 14))
                                        .foregroundStyle(.brRed)
                                    Image(systemName: "arrow.right")
                                        .foregroundStyle(.brBlack)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(modelData.cuisineArray, id: \.self) { cuisine in
                                    NavigationLink {
                                        CuisineListView(modelData: modelData, cuisine: cuisine)
                                    } label: {
                                        VStack{
                                            Image(cuisine)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 110, height: 110)
                                                .clipShape(Circle())
                                            Text(cuisine.capitalized)
                                                .font(.custom(Font.medium, size: 14))
                                                .foregroundStyle(.black)
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.leading, modelData.cuisineArray[0] == cuisine ? 16 : 0)
                                    }
                                }
                            }
                        }
                    }
                    Spacer(minLength: 80)
                }
                    
                    
                    
            }
        }.navigationViewStyle(.stack)
        
    }
    
}

#Preview {
    HomeView(searchEnable: .constant(false), modelData: ModelData())
}
