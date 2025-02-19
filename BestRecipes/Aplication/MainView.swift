//
//  MainView.swift
//  BestRecipes
//
//  Created by Руслан on 03.07.2024.
//

import SwiftUI

struct MainView: View {
    
    @State var index = 0
    @StateObject var modelData = ModelData()
    @State var searchOn: Bool = false
    
    @State var isHomeRootScreen = false
    @State var scaleAmount: CGFloat = 1
    @State var opacityAmount: CGFloat = 1
    
    var body: some View {
        let homeView = HomeView(searchEnable: $searchOn, modelData: modelData)
        let favoriteRecipesView = FavoriteRecipesView(modelData: modelData)
        let addDishView = AddDishView(modelData: modelData, tabBarIndex: $index)
        let randomRecipe = RandomRecipeView(modelData: modelData)
        
        ZStack {
            ZStack {
                if index == 0 {
                    homeView
                }
                if index == 1 {
                    favoriteRecipesView
                }
                if index == 2 {
                    addDishView
                }
                if index == 3 {
                    randomRecipe
                }
                if index == 4 {
                    ProfileView(modelData: modelData)
                }
                VStack {
                    Spacer()
                    
                    TabBarView(index: $index)
                        .offset(y: modelData.tabBarHide ? 300 : 0)
                }
                .ignoresSafeArea()
                .animation(.easeInOut, value: modelData.tabBarHide)
                if !isHomeRootScreen {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.white)
                        Image("launchScreen")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(scaleAmount)
                            .frame(width: 80)
                    }
                    .opacity(opacityAmount)
                }
            }
        }
        .animation(.easeInOut(duration: 0.1), value: index)
        .ignoresSafeArea()
        .onAppear {
            // уменьшаем картинку
            withAnimation(.easeInOut(duration: 1).delay(2)) {
                scaleAmount = 0.6
            }
            // увеличиваем картинку
            withAnimation(.easeInOut(duration: 2)) {
                scaleAmount = 2.5
            }
            // картинка улетает
            withAnimation(.easeInOut(duration: 0.4).delay(1.7)) {
                scaleAmount = 0
                opacityAmount = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                isHomeRootScreen = true
            }
        }
    }
}

#Preview {
    MainView()
}

