//
//  ProfileView.swift
//  BestRecipes
//
//  Created by Denis Evdokimov on 7/9/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var modelData: ModelData
    @State private var profileImage: UIImage? //= UIImage(named: "defaultProfileImage")
    @State private var showImagePicker: Bool = false
    @AppStorage("nameUser") var name: String = "Gordon"
    @AppStorage("surnameUser") var surname: String = "Ramsay"
//
    var body: some View {
        VStack {
            Text("My profile")
                .font(.custom(Font.semiBold, size: 30))
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
                    VStack {
                        HStack {
                            Text("Name: ")
                                .font(.custom(Font.light, size: 10))
                                .foregroundStyle(.brGray)
                                .frame(height: 2)
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.5)
                                .frame(height:30)
                            TextField("Name", text: $name)
                                .font(.custom(Font.regular, size: 20))
                                .foregroundStyle(.brBlack)
                                .padding()
                        }
                        .frame(height:30)
                        
                    }
                    VStack {
                        HStack {
                            Text("Surname: ")
                                .font(.custom(Font.light, size: 10))
                                .foregroundStyle(.brGray)
                                .frame(height: 2)
                            Spacer()
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.5)
                                .frame(height:30)
                            TextField("Surname", text: $surname)
                                .font(.custom(Font.regular, size: 20))
                                .foregroundStyle(.brBlack)
                                .padding()
                        }
                        .frame(height:30)
                        
                    }
                    .padding(.top, 10)
                    
                }.padding(.leading)
                
            }
            HStack {
                Text("My recipes")
                    .font(.custom(Font.semiBold, size: 30))
                .padding(.top, 30)
                Spacer()
            }
            
            // Список рецептов
            if modelData.savedDishies.isEmpty {
                VStack {
                    Spacer()
                    Text("no saved recipes")
                        .font(.custom(Font.regular, size: 20))
                    Spacer()
                }
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(modelData.savedDishies, id: \.id) { dish in
                        NavigationLink{
                            RecipeDetailView(modelData: modelData, id: dish.id)
                        } label: {
                            HStack{
                                ZStack {
                                    TrendingDishElement(bigSize: true, dish: DishLightModel(userModel: dish))
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
        }
    }
    
}

extension ProfileView {
    
    
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
    ProfileView(modelData: ModelData())
}
