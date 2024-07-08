//
//  ProfileView.swift
//  BestRecipes
//
//  Created by Denis Evdokimov on 7/8/24.
//

import SwiftUI

struct ProfileView: View {
   
    @State private var profileImage: UIImage? = UIImage(named: "defaultProfileImage")
    @State private var showImagePicker: Bool = false
    @AppStorage("name") var name: String = ""
    @AppStorage("surname") var surname: String = ""
    
    var body: some View {
        VStack {
            Text("My profile")
                .font(.title)
                .padding(.top, 16)
            // Профильное изображение
            HStack {
                AvatarView()
                    .padding()
                    .onTapGesture {
                        self.showImagePicker = true
                }
                VStack {
                    TextField("Имя", text: $name)
                    TextField("Фамилия", text: $surname)
                }
            }
           
            
            HStack() {
                Text("My recipes")
                    .font(.headline)
                    .padding(.top, 32)
                Spacer()
            }.padding()
               
            
            // Список рецептов
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<2) { _ in
                        EmptyView()
                        //  RecipeCardView()
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
        }
    }
}

#Preview {
    ProfileView()
}

