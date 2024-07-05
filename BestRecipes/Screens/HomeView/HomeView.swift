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
    @StateObject var modelData: ModelData
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                //header
                HStack {
                    Text("Get amazing recipes for cooking")
                        .lineLimit(2)
                        .font(.custom(Font.bold, size: 24))
                    Spacer()
                }
                .padding(.horizontal, 16)
                // search
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 0.5)
                        .foregroundStyle(.brGray)
                        .frame(height: 44)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search recipe", text: $userSearch)
                            .font(.custom(Font.light, size: 15))
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 60)
                .padding(.horizontal, 16)
                SearchBar(searchText: $userSearch)
                    .padding(.horizontal, 16)
                //trending now
                VStack {
                    HStack{
                        HStack {
                            Text("Trending now 🔥")
                                .font(.custom(Font.medium, size: 20))
                        }
                        Spacer()
                        HStack {
                            NavigationLink {
                                Text("see all")
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
                                ZStack {
                                    TrendingDishElement(bigSize: false, dish: dish)
//                                        .frame(width: 280)
                                        
                                    VStack {
                                        HStack {
                                            RatingElement(bg: true, rating: dish.spoonacularScore)
                                            Spacer()
                                            Button {
                                                //TODO:  add to favorite
                                            } label : {
                                                //need add check to fav and logic
                                                FavoriteElement(checkFavorite: true)
                                            }
                                        }
                                        .padding(12)
                                        Spacer()
                                    }
                                }
                                .padding(.leading, 16)
                                
                                
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
                    //Course list
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(modelData.courceArray, id: \.self) { course in
                                Button {
                                    userChoiseCourse = course
                                    Task {
                                        do {
                                            try await modelData.fetchDishByCourse(course)
                                        }
                                    }
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
                    // dish list
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(modelData.popularDishes, id: \.id) { dish in
                                ZStack {
                                    CategoryDishElement(dish: dish)
                                    HStack {
                                        Spacer()
                                        VStack{
                                            Spacer()
                                            Button {
                                                // TODO: check and add to
                                            } label: {
                                                FavoriteElement(checkFavorite: true)
                                            }
                                            .padding(10)
                                            
                                        }
                                    }
                                }
                                .padding(.leading, 16)
                                .padding(.top, 5)
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
                                Text("see all")
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
                            ForEach(modelData.recentDishes, id: \.id) { dish in
                                RecentDishElement(dish: dish)
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
                                Text("see all")
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
                                VStack{
                                    Circle()
                                        .frame(width: 110, height: 110)
                                        .foregroundStyle(.thinMaterial)
                                    Text(cuisine)
                                        .font(.custom(Font.medium, size: 14))
                                }
                                .padding(.vertical, 10)
                            }
                        }
                    }
                }
                Spacer(minLength: 150)
            }

           
        }
        
    }
}

#Preview {
    HomeView(modelData: ModelData())
}
