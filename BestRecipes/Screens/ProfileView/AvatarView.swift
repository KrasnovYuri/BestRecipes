//
//  AvatarView.swift
//  BestRecipes
//
//  Created by Denis Evdokimov on 7/8/24.
//

import SwiftUI

struct AvatarView: View {
    @State private var profileImage: UIImage? = UIImage(named: "defaultProfileImage")
  
    var body: some View {
        if let profileImage = profileImage {
            Image(uiImage: profileImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }
}

#Preview {
    AvatarView()
}
