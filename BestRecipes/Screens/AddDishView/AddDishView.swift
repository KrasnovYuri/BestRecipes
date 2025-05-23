//
//  AddDishView.swift
//  BestRecipes
//
//  Created by Руслан on 10.07.2024.
//

import SwiftUI

struct AddDishView: View {
    @StateObject var modelData: ModelData
    @State var ingredients: [UserIngredient] = [UserIngredient()]
    @State var id: Int = 0
    @State var title = ""
    @State var serves = 0
    @State var cookTime = 0
    @State var units = Unit.allCases.map {$0.rawValue}
    @State var textPrint = false
    @State var saved = false
    @Binding var tabBarIndex: Int
    @State private var profileImage: UIImage?
    @State private var showImagePicker: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView (.vertical, showsIndicators: false){
                        VStack {
                            HStack {
                                if let profileImage = profileImage {
                                    Image(uiImage: profileImage)
                                        .resizable()
                                        .frame(height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .scaledToFit()
                                        .onTapGesture {
                                            self.showImagePicker = true
                                        }
                                } else {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(height: 200)
                                            .scaledToFill()
                                        VStack {
                                            Image(systemName: "plus.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100)
                                                .foregroundStyle(.brWhite)
                                            Text("Add photo")
                                                .foregroundStyle(.brWhite)
                                        }
                                    }.onTapGesture {
                                        self.showImagePicker = true
                                    }
                                }
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(title.count > 0 ? .brRed : .black)
                                
                                TextField("Enter dish name", text: $title)
                                    .font(.custom(Font.regular, size: 14))
                                    .padding(.horizontal, 10)
                            }.frame(height: 44)
                                .padding(.vertical, 10)
                            VStack {
                                AddDishElement(serves: true, value: $serves)
                                AddDishElement(serves: false, value: $cookTime)
                                    .padding(.vertical, 5)
                            }
                            VStack {
                                HStack {
                                    Text("Ingredients")
                                        .font(.custom(Font.semiBold, size: 20))
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                VStack {
                                    if ingredients.count != 0 {
                                        ForEach($ingredients, id: \.id) { ingredient in
                                            HStack {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(lineWidth: 1)
                                                        .foregroundStyle(.brGray)
                                                    TextField("Item name", text: ingredient.title)
                                                        .font(.custom(Font.regular, size: 14))
                                                        .padding(.horizontal, 10)
                                                }
                                                .frame(width: 200)
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(lineWidth: 1)
                                                        .foregroundStyle(.brGray)
                                                    TextField("amount", text: ingredient.amount)
                                                        .font(.custom(Font.regular, size: 14))
                                                        .padding(.horizontal, 10)
                                                        .keyboardType(.decimalPad)
                                                }
                                                .frame(width: 70)
                                                
                                                Button {
                                                    switch ingredient.wrappedValue.unit {
                                                    case "gr" : ingredient.wrappedValue.unit = "ml"
                                                    case "ml": ingredient.wrappedValue.unit = "sp"
                                                    case "sp": ingredient.wrappedValue.unit = "gr"
                                                    default : ingredient.wrappedValue.unit = "gr"
                                                    }
                                                } label: {
                                                    ZStack {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(lineWidth: 1)
                                                            .foregroundStyle(.brGray)
                                                        Text(ingredient.wrappedValue.unit)
                                                            .foregroundStyle(.black)
                                                            .font(.custom(Font.regular, size: 14))
                                                            .padding(.horizontal, 10)
                                                    }
                                                    .frame(width: 50)
                                                }
                                                Button {
                                                    ingredients = ingredients.filter({ UserIngredient in
                                                        UserIngredient.id != ingredient.id
                                                    })
                                                } label: {
                                                    Image("minusButton")
                                                }
                                            }
                                            .frame(height: 45)
                                        }
                                    }
                                    Button {
                                        ingredients.append(UserIngredient())
                                    } label: {
                                        HStack {
                                            Image("Plus")
                                            Text("Add new Ingredient")
                                                .font(.custom(Font.regular, size: 16))
                                                .foregroundStyle(.black)
                                            Spacer()
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                        .frame(width: 370)
                    }
                    Spacer()
                    HStack {
                        Button {
                            saved = true
                            let userDish = DishUserModel(title: title, id: id, score: 60.0, time: cookTime, credits: "\(modelData.userName) \(modelData.userSurname)", imagePath: "userDish\(id).jpg", ingredients: ingredients, serves: serves)
                            modelData.saveSavedRecipe(recipe: userDish)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.brRed)
                                Text("Create recipe")
                                    .font(.custom(Font.medium, size: 16))
                                    .foregroundStyle(.white)
                            }
                            .frame(height: 56)
                        }
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Create recipe")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundColor(.black)
                                    .lineLimit(2)
                            }
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    tabBarIndex = 0
                                } label: {
                                    Image(.backButton)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                .blur(radius: saved ? 10 : 0 )
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    if profileImage != nil {
                        saveProfileImage(id: id )
                    }
                }) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                }
                .padding(.horizontal, 16)
                if saved {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                        VStack{
                            Text("Recipe successfully saved")
                                .font(.custom(Font.semiBold, size: 20))
                                .foregroundStyle(.black)
                                .padding(20)
                            HStack{
                                Button {
                                    tabBarIndex = 0
                                    ingredients = [UserIngredient()]
                                    saved = false
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 0.7)
                                            .frame(width: 160, height: 70)
                                            .foregroundStyle(.brGray)
                                        Text("Back to main")
                                            .font(.custom(Font.semiBold, size: 16))
                                            .foregroundStyle(.black)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .frame(width: 350, height: 200)
                }
            }
            //Animation
            .animation(.easeInOut, value: ingredients.count)
            .animation(.easeInOut, value: saved)
            //On Appear
            .onAppear {
                id = Int.random(in: 1...30000)
                modelData.tabBarHide = true
            }
            .onDisappear{
                modelData.tabBarHide = false
            }
        }
    }
}


extension AddDishView {
    
    private func saveProfileImage(id: Int) {
        guard let image = profileImage else { return }
        
        // Получаем URL папки для сохранения
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsURL.appendingPathComponent("BestRecipes")
        
        do {
            // Создаем папку, если она не существует
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
            // Формируем URL файла для сохранения
            let fileURL = folderURL.appendingPathComponent("userDish\(id).jpg")
            
            // Сохраняем изображение в файл
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: fileURL)
                print("Изображение сохранено по пути: \(fileURL.path)")
            }
            return
        } catch {
            print("Ошибка при сохранении/чтении изображения: \(error)")
        }
    }
}

#Preview {
    AddDishView(modelData: ModelData(), tabBarIndex: .constant(2))
}
