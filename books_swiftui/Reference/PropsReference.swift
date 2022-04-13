//
//  PropSample.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/4/22.
//

import Foundation
import SwiftUI

//@State
// normally private
// state for the view itself and its subviews
// consider it a 'value type'

//@Binding
// handed in through the initializer
// a weak reference to State

//@StateObject
// declared once, by the ower ('strong')
// listen for changes to any of its marked @Published properties

//@ObservedObject
// handed in through an initializer
// a 'weak' reference
// listen for changes to any of its marked @Published properties

//@EnvironmentObject
// automatically picked up through the environment
// environment is influenced by parent views

//@Environment
// is specifically there to work with SwiftUI’s own pre-defined keys
// system level environments provide background notifications and locales etc.
// Can return the same value/class types for many keys via apples API

//@AppStorage
// stores and retrieves the variable from userdefaults type storage.



struct PropertiesSampleView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesSampleView()
            .environmentObject(AppConfiguration())
    }
}



class PublishingClassSample: ObservableObject {
    @Published var publishedInt: Int = 0
}

struct PropertiesSampleView: View {

    @Environment(\.locale) private var locale
    
    @State var sharableState: Int = 0
    @StateObject var sharableObject = PublishingClassSample()

    var body: some View {
        return NavigationView {
            VStack {
                Button("Add To Count: \(sharableObject.publishedInt)") {
                    sharableObject.publishedInt += 1
                }
                NavigationLink(destination: PropertiesSampleChildView(sharedObject: sharableObject, sharedState: $sharableState)) {
                    Text("Show Detail View")
                }
            }
            .navigationTitle("SwiftUI")
        }
        .onChange(of: locale) { newValue in
            print("locale changed: \(newValue)")
        }
    }
}

// A view that expects to find a GameSettings object
// in the environment, and shows its score.
struct PropertiesSampleChildView: View {
    
    @EnvironmentObject var config: AppConfiguration
    @ObservedObject var sharedObject: PublishingClassSample
    @Binding var sharedState: Int

    var body: some View {
        VStack {
            Text("Score: \(sharedObject.publishedInt)")
                .foregroundColor(config.theme.primaryColor)
            Button("Add To Count") {
                sharedObject.publishedInt += 1
            }
            Button("Swap Mode") {
                let nextTheme = config.theme.type == .light
                    ? AppConfiguration.ThemeOption.dark
                    : AppConfiguration.ThemeOption.light
                config.updateTheme(option: nextTheme)
            }
        }.background(.white)
    }
    
}
