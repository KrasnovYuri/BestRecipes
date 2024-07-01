//
//  HomeView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct HomeView: View {
    @State var index = 1
    var body: some View {
        VStack {
            Spacer()
            TabBarView(index: $index)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
