//
//  MainView.swift
//  BestRecipes
//
//  Created by Руслан on 03.07.2024.
//

import SwiftUI

struct MainView: View {
    @State var index = 0
    @State var searchIn = true
    @StateObject var modelData = ModelData()
    
    var body: some View {
        var homeView = HomeView(modelData: modelData)
        var savedRecipesView = SavedRecipesView(modelData: modelData)
        ZStack {
            if index == 0 {
                homeView
            }
            if index == 1 {
                savedRecipesView
            }
            VStack {
                Spacer()
                if searchIn {
                    TabBarView(index: $index)
                }
                    
            }
            .ignoresSafeArea()
            .onAppear{
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
