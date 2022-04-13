//
//  ViewsReference.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/5/22.
//

import Foundation
import SwiftUI
import MapKit

//FormViewsReference
//TabViewsReference
//NavigationViewsReference
//StaticListViewsReference
//DynamicListViewsReference
//MapViewReference

struct ViewsReference_Previews: PreviewProvider {
    static var previews: some View {
        MapViewReference()
    }
}



// Forms
struct FormViewsReference: View {
    
    @State var quantity: Double = 5
    @State var date: Date = Date()
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Plain Text")
                    Stepper(value: $quantity, in: 0...10, label: { Text("Quantity: \(Int(quantity))") })
                }
                Section {
                    DatePicker(selection: $date, label: { Text("Date") })
                    // If this isn't embedded in a NavigationView it will be disabled
                    Picker(selection: $selection, content: {
                        Text("Value 1").tag(0)
                        Text("Value 2").tag(1)
                        Text("Value 3").tag(2)
                        Text("Value 4").tag(3)
                    }, label: {
                        Text("Picker Name")
                    })
                }
            }
        }
    }
}



// TabViews
struct TabViewsReference: View {
    var body: some View {
        TabView {
            Text("Menu")
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            Text("Order")
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}



// Navigation
struct NavigationViewsReference: View {
    
    @State private var isBindingActive: Bool = false
    @State private var fromTagNavigation: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("simple link", destination: Text("simple link"))
                NavigationLink("with binding", isActive: $isBindingActive) {
                    Text("bound destination")
                }
                Button("binding from button") {
                    isBindingActive.toggle()
                }
                // Uses EmptyView
                NavigationLink(destination: Text("with tag"), tag: "tagged", selection: $fromTagNavigation) { EmptyView() }
                Button("select tag") {
                    self.fromTagNavigation = "tagged"
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Title")
            .navigationBarItems(trailing: trailingNavItem())
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(false)
        }
        .statusBar(hidden: false)
    }
    
    private func trailingNavItem() -> some View {
        HStack {
            Button("1") {
                isBindingActive.toggle()
            }
            Spacer(minLength: 18)
            Button("2") {
                isBindingActive.toggle()
            }
        }
    }
}



// Static Lists
struct StaticListViewsReference: View {
    
    @State var inputName: String = ""

    var body: some View {
        List {
            Section(header: Text("UIKit"), footer: Text("We will miss you")) {
                Text("0")
                Text("1")
                Text("2")
            }
            Section(header: Image(systemName: "circle"), footer: Color.red) {
                HStack {
                    Text("Name:")
                    TextField("Your Name Here...", text: $inputName)
                }
                HStack {
                    Text("Password:")
                    SecureField("Your Password Here...", text: $inputName)
                }
                Button("Login", action: {
                    print("login...")
                }).padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            }
        }
    }
    
}



// Dynamic Lists
struct ColorBacking {
    let id: Int
    let name: String
    let color: Color
}

struct DynamicListViewsReference: View {
    
    @State var displayItems: [ColorBacking] = [
        ColorBacking(id: 0, name: "red", color: .red),
        ColorBacking(id: 1, name: "green", color: .green),
        ColorBacking(id: 2, name: "orange", color: .blue)
    ]
    
    var body: some View {
        List(displayItems, id: \.id) { color in
            ColorRow(colorBacking: color)
        }
    }
}

struct ColorRow: View {
    
    let colorBacking: ColorBacking
    
    var body: some View {
        HStack {
            // Color fills all available space
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(colorBacking.color)
                .frame(width: 50, height: 50)
            Text(colorBacking.name)
        }
    }
}





// MapViews

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapViewReference: View {

    @State var annotations: [Location] = [
        Location(
            name: "cool",
            coordinate: CLLocationCoordinate2D(latitude: 41.234520504, longitude: -85.1771039)
        )
    ]

    @State var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.234520504, longitude: -85.1771039),
        span: MKCoordinateSpan(latitudeDelta: 0.0967386, longitudeDelta: 0.08405752)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { loc in
            MapMarker(coordinate: loc.coordinate, tint: .red)
        }
        .statusBar(hidden: true)
        .onChange(of: region.center.latitude) { newValue in
            print("new region: \(region)")
        }
    }
}
