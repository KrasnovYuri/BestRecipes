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
    var body: some View {
        ZStack {
            VStack {
                TextField("search", text: $userSearch)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
