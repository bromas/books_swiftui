//
//  books_swiftuiApp.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/4/22.
//

import SwiftUI

@main
struct books_swiftuiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    
    @StateObject private var loginVM = Composer.shared.buildLoginVM()
    
    @ViewBuilder
    var body: some View {
        switch loginVM.auth {
            case .success(_, _):
                Main()
            case .loading:
                GenericLoading()
            default:
                Login(vm: loginVM)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
