//
//  TestView.swift
//  BestRecipes
//
//  Created by Юрий on 01.07.2024.
//

import SwiftUI

struct TestView: View {

    // random dishes

    @StateObject private var modelData = ModelData()
    var check = [1,2,3,4,5]

    var body: some View {
        NavigationView {
            HStack {
                Button {
//                    UserDefaultsService.shared.removeData(forKey: "userName")
//                    UserDefaultsService.shared.removeData(forKey: "userSurname")
//                    UserDefaultsService.shared.save(structs: "Gordon", forKey: "userName")
//                    if let saved: String = UserDefaultsService.shared.get(forKey: "userName") {
//                        print(saved)
////                       
//                    }
                    
                } label: {
                    Text("Button")
                }

            }

        }
        
    }
}

#Preview {
    TestView()
}
