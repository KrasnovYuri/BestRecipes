//
//  ProfileView.swift
//  BestRecipes
//
//  Created by Denis Evdokimov on 7/9/24.
//

import SwiftUI

struct ProfileView: View {
   
    @State private var profileImage: UIImage? //= UIImage(named: "defaultProfileImage")
    @State private var showImagePicker: Bool = false
    @State private var myRecipes: [DishLightModel] = .init()
    @AppStorage("nameUser") var name: String = ""
    @AppStorage("surnameUser") var surname: String = ""
    
    var body: some View {
        VStack {
            Text("My profile")
                .font(.title)
                .padding(.top, 16)
            HStack {
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                }
                VStack {
                    TextField("Имя", text: $name)
                    TextField("Фамилия", text: $surname)
                }.padding(.leading)
                
            }
            HStack {
                Text("My recipes")
                    .font(.title)
                .padding(.top, 23)
                Spacer()
            }
            
            // Список рецептов
            if myRecipes.isEmpty {
                VStack {
                    Spacer()
                    Text("no saved recipes")
                    Spacer()
                }
            } else {
                ScrollView {
                    ForEach(myRecipes, id: \.id) { dish in
                        NavigationLink(destination: RecipeDetailView(id: dish.id)) {
                            HStack{
                                ZStack {
                                    TrendingDishElement(bigSize: true, dish: dish)
                                    VStack {
                                        HStack {
                                            RatingElement(bg: true, rating: dish.spoonacularScore)
                                            Spacer()
                                           
                                        }
                                        .padding(10)
                                        Spacer()
                                    }
                                }
                                .padding(.leading, 20)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if profileImage != nil {
                saveProfileImage()
            }
        }) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
        }
        .onAppear {
            loadProfileImage()
            loadRecipes()
        }
    }
    
}

extension ProfileView {
    
    private func loadRecipes() {
        if let savedRecepies: [DishLightModel] = UserDefaultsService.shared.get(forKey: "Saved") {
            myRecipes = savedRecepies
        }
    }
    
   private func loadProfileImage() {
       let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       let folderURL = documentsURL.appendingPathComponent("BestRecipes")
       let fileURL = folderURL.appendingPathComponent("profileImage.jpg")
       if FileManager.default.fileExists(atPath: folderURL.path),
          let loadImage = UIImage(contentsOfFile: fileURL.path) {
           profileImage = loadImage
       }
    }
    
    private func saveProfileImage() {
        guard  let image = profileImage else { return }

        // Получаем URL папки для сохранения
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsURL.appendingPathComponent("BestRecipes")

        do {
            // Создаем папку, если она не существует
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
            // Формируем URL файла для сохранения
            let fileURL = folderURL.appendingPathComponent("profileImage.jpg")
            
            // Сохраняем изображение в файл
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: fileURL)
                print("Изображение сохранено по пути: \(fileURL.path)")
            }
        } catch {
            print("Ошибка при сохранении/чтении изображения: \(error)")
        }
    }
}

#Preview {
    ProfileView()
}
