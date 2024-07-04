//
//  FavoriteElement.swift
//  BestRecipes
//
//  Created by Руслан on 04.07.2024.
//

import SwiftUI

struct FavoriteElement: View {
    @State var checkFavorite: Bool
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
            Image(checkFavorite ? "TabBarBookmarkActive" : "TabBarBookmarkInactive")
                .resizable()
                .scaledToFit()
                .frame(height: 18)
        }
        .frame(width: 32, height: 32)
    }
}

#Preview {
    FavoriteElement(checkFavorite: true)
}

