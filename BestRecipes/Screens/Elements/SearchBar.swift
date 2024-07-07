//
//  SearchBar.swift
//  BestRecipes
//
//  Created by Юрий on 04.07.2024.
//

import SwiftUI


//struct SearchBar: View {
//    
//    @Binding var searchText: String
//    @State var searchViewPresented = false
//    
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        HStack {
//            Image(.search)
//            
//            TextField("Search recipes", text: $searchText)
//                .font(.custom(Font.regular, fixedSize: 16))
//                .autocorrectionDisabled()
//                .onSubmit {
//                    searchViewPresented.toggle()
//                }
//            
//            if !searchText.isEmpty {
//                Button {
//                    UIApplication.shared.endEditing()
//                    searchText = ""
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(.plus)
//                        .rotationEffect(.degrees(45))
//                }
//            }
//        }
//        .padding(.vertical, 8)
//        .padding(.horizontal, 16)
//        
//        .background(
//            RoundedRectangle(cornerRadius: 15)
//                .stroke(lineWidth: 0.5)
//                .foregroundStyle(searchText.isEmpty ? Color(.brGray) : Color(.brRed))
//        )
//        .overlay(
//            NavigationLink(destination: SearchView(modelData: ModelData()), isActive: $searchViewPresented) {}
//        )
//    }
//    
//}
//
//#Preview {
//    SearchBar(searchText: .constant(""))
//}

