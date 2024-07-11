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

    var body: some View {
        let homeView = HomeView(searchEnable: $searchOn, modelData: modelData)
        let savedRecipesView = SavedRecipesView(modelData: modelData)

        ZStack {
            //Color("BRGold")

            if isHomeRootScreen {
                ZStack {
                    if index == 0 {
                        homeView
                    }
                    if index == 1 {
                        savedRecipesView
                    }
                    if index == 2 {
                        Text (homeView.searchEnable.description)
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

                }

            } else {
                Image("launchScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scaleAmount)
                    .frame(width: 80)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            Task {
                do {
                    try await modelData.fetchAllData()
                }
            }
            // уменьшаем картинку
            withAnimation(.easeInOut(duration: 1).delay(2)) {
                scaleAmount = 0.6
            }
            // увеличиваем картинку
            withAnimation(.easeInOut(duration: 2)) {
                scaleAmount = 20
            }
            // картинка улетает
            withAnimation(.easeInOut(duration: 0.4).delay(1.7)) {
                scaleAmount = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isHomeRootScreen = true
            }
        }
    }
}

#Preview {
    MainView()
}

