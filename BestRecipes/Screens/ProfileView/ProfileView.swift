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
    @State private var delete: Bool = false
    @State private var deleteId: Int = 0
    //
    var body: some View {
        NavigationView {
            ZStack {
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
                                    TextField("Name", text: $modelData.userName)
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
                                    TextField("Surname", text: $modelData.userSurname)
                                        .font(.custom(Font.regular, size: 20))
                                        .foregroundStyle(.brBlack)
                                        .padding()
                                }
                                .frame(height:30)
                                
                            }
                            .padding(.top, 10)
                            
                        }
                        .padding(.leading)
                        
                    }
                    .padding(.horizontal, 16)
                    HStack {
                        Text("My recipes")
                            .font(.custom(Font.semiBold, size: 30))
                        
                        Spacer()
                        //                Button {
                        //                    UserDefaultsService.shared.removeData(forKey: "Saved")
                        //                    modelData.savedDishies = []
                        //                    modelData.loadSavedRecipes()
                        //                } label: {
                        //                    Text("Clear all")
                        //                        .foregroundStyle(.brRed)
                        //
                        //                }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 30)
                    
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
                                NavigationLink {
                                    Text("")
                                    RecipeDetailView(modelData: modelData, disappearIsOn: true, id: dish.id, dish: RecipeDetails(), userRecipe: true)
                                } label: {
                                    ZStack {
                                        TrendingDishElement(bigSize: true, dishUser: dish)
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Button {
                                                    delete = true
                                                    deleteId = dish.id
                                                } label: {
                                                    ZStack {
                                                        Circle()
                                                            .foregroundStyle(.white)
                                                        Image(systemName: "trash.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: 18)
                                                            .foregroundStyle(.brRed)
                                                    }
                                                    .frame(width: 32, height: 32)
                                                }
                                                .padding(.trailing, 16)
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding(.vertical, 25)
                                    
                                }
                            }
                            Spacer(minLength: 80)
                        }
                    }
                }
                .blur(radius: delete ? 20 : 0 )
                if delete {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .shadow(radius: 10)
                            .foregroundStyle(.white)
                        VStack {
                            Text("Delete from saved?")
                                .multilineTextAlignment(.center)
                                .font(.custom(Font.semiBold, size: 18))
                                .padding(.top, 20)
                                .frame(height: 50)
                            HStack {
                                Button {
                                    modelData.deleteFromSaved(recipeId: deleteId)
                                    delete = false
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 0.3)
                                            .foregroundStyle(.brRed)
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.brRed)
                                            .scaleEffect(0.8)
                                    }
                                }
                                .frame(width: 100, height: 50)
                                
                                Button {
                                    delete = false
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 0.3)
                                            .foregroundStyle(.black)
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.black)
                                            .scaleEffect(0.8)
                                    }
                                }
                                .frame(width: 100, height: 50)
                            }
                            .padding()
                        }
                        
                    }
                    .frame(width: 300, height: 150)
                }
            }
            //animation
            .animation(.easeInOut, value: delete)
            .animation(.easeInOut, value: modelData.savedDishies.count)
            
            //  sheet
            .sheet(isPresented: $showImagePicker, onDismiss: {
                if profileImage != nil {
                    saveProfileImage()
                }
            }) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
            }
            // onAppear
            .onAppear {
                modelData.loadSavedRecipes()
                loadProfileImage()
            }
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
