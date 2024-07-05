//
//  UIApplication.swift
//  BestRecipes
//
//  Created by Юрий on 05.07.2024.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
