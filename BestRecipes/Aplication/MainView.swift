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

    @State var isMainView = false
    @State var scaleAmount: CGFloat = 1

    var body: some View {
        ZStack {
            if isMainView {
                let homeView = HomeView(searchEnable: $searchOn, modelData: modelData)
                let savedRecipesView = SavedRecipesView(modelData: modelData)

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
                        //                    ProfileView()
                    }

                    VStack {
                        Spacer()
                        if !searchOn {
                            TabBarView(index: $index)
                        }
                    }
                    .ignoresSafeArea()
                    .onAppear {
                        Task {
                            do {
                                try await modelData.fetchAllData()
                            }
                        }
                    }
                }

            } else {
                // launch screen
                Image("launchScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scaleAmount)
                    .frame(width: 150)
            }
        }
        .onAppear {
        }
    }
}

#Preview {
    MainView()
}
