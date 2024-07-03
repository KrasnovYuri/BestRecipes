//
//  MainView.swift
//  BestRecipes
//
//  Created by Руслан on 03.07.2024.
//

import SwiftUI

struct MainView: View {
    @State var index = 1
    @State var searchIn = true
    var body: some View {
        ZStack {
           HomeView()
            VStack {
                Spacer()
                if searchIn {
                    TabBarView(index: $index)
                }
                    
            }
            .ignoresSafeArea()

            
        }
        
    }
}

#Preview {
    MainView()
}
