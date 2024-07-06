//
//  BestRecipesApp.swift
//  BestRecipes
//
//  Created by Юрий on 30.06.2024.
//

import SwiftUI

@main
struct BestRecipesApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                StartView()
            } else {
                MainView()
            }
        }
    }
}
