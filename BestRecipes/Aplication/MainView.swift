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
    var body: some View {
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
        
        
    }
}

#Preview {
    MainView()
}
