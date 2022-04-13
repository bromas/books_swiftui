//
//  AppConfiguration.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/4/22.
//

import SwiftUI

class AppConfiguration: ObservableObject {
    
    @Published var theme: Theme = Theme(type: .light, primaryColor: .purple, secondaryColor: .green)
    @Published var env: Env = Env(identifier: .development)
    
    func updateTheme(option: ThemeOption) {
        theme = option.asTheme()
    }
    
}

// Environment
extension AppConfiguration {
    
    struct Env {
        enum Identifier {
            case production
            case development
            case qa
        }
        
        let identifier: Identifier
    }
    
}

// Theme
extension AppConfiguration {
    
    struct Theme {
        let type: ThemeOption
        let primaryColor: Color
        let secondaryColor: Color
    }
    
    enum ThemeOption {
        case light
        case dark
        case alternativeLight
        case alternativeDark
        
        func asTheme() -> Theme {
            switch self {
            case .light:
                return Theme(type: .light, primaryColor: .purple, secondaryColor: .green)
            case .dark:
                return Theme(type: .dark, primaryColor: .black, secondaryColor: .yellow)
            case .alternativeLight:
                return Theme(type: .alternativeLight, primaryColor: .purple, secondaryColor: .green)
            case .alternativeDark:
                return Theme(type: .alternativeDark, primaryColor: .purple, secondaryColor: .green)
            }
        }
    }
    
}
