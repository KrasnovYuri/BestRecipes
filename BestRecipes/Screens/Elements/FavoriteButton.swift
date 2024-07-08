//
//  FavoriteButton.swift
//  BestRecipes
//
//  Created by Evgeniy K on 08.07.2024.
//

import SwiftUI

struct FavoriteButton: View {

    @Binding var isSaved: Bool

    var body: some View {
        Button {
            isSaved.toggle()
        } label: {
            Image(isSaved ? "TabBarBookmarkActive" : "TabBarBookmarkInactive")
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
        }
    }
}

#Preview {
    FavoriteButton(isSaved: .constant(true))
}
