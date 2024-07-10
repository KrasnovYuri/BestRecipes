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
    @State var userChoiseCourse = "mainCourse"
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
                                    DishesListView(dishesList: modelData.trendingDishes, textHeader: "Trending now")
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
                                    NavigationLink(destination: RecipeDetailView(id: dish.id )) {
                                        ZStack {
                                            TrendingDishElement(bigSize: false, dish: dish)
                                            VStack {
                                                HStack {
                                                    RatingElement(bg: true, rating: dish.spoonacularScore)
                                                    Spacer()
                                                    FavoriteElement(checkFavorite: true)
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
                                        
                                    }
                                }
                            }
                        }
                        // Popular dish list
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(modelData.foodCategoryPopularDishes, id: \.id) { dish in
                                    NavigationLink{
                                        RecipeDetailView(id: dish.id)
                                    } label: {
                                        ZStack {
                                            CategoryDishElement(dish: dish)
                                            HStack {
                                                Spacer()
                                                VStack{
                                                    Spacer()
                                                    FavoriteElement(checkFavorite: true)
                                                        .padding(10)
                                                    
                                                }
                                            }
                                            .padding(.leading, 16)
                                            .padding(.top, 5)
                                        }
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
                            .padding(.horizontal, 16)
                            Spacer()
                            HStack {
                                NavigationLink {
                                    DishesListView(dishesList: modelData.recentDishes, textHeader: "Recent dishes")
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
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(modelData.recentDishes, id: \.id) { dish in
                                    NavigationLink(destination: RecipeDetailView(id: dish.id)) {
                                        RecentDishElement(dish: dish)
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
                                Text("Popular kitchens")
                                    .font(.custom(Font.medium, size: 20))
                            }
                            .padding(.horizontal, 16)
                            Spacer()
                            HStack {
                                NavigationLink {
                                    CuisineAllListView()
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
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(modelData.cuisineArray, id: \.self) { cuisine in
                                    NavigationLink {
                                        CuisineListView(cuisine: cuisine)
                                    } label: {
                                        VStack{
                                            Circle()
                                                .frame(width: 110, height: 110)
                                                .foregroundStyle(.thinMaterial)
                                            Text(cuisine)
                                                .font(.custom(Font.medium, size: 14))
                                                .foregroundStyle(.black)
                                        }
                                        .padding(.vertical, 10)
                                    }
                                }
                            }
                        }
                    }
                    Spacer(minLength: 150)
                }
                    
                    
                    
            }
        }
        
    }
    
}

#Preview {
    HomeView(searchEnable: .constant(false), modelData: ModelData())
}
