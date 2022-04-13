//
//  RootView.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/5/22.
//

import SwiftUI

private let rootNavigationTitle = "Books"
private let newBookTitle = "create"
private let noIdTag = "missingBookId"

struct Main: View {

    @State private var viewBookId: String? = nil
    @State private var createBookId: String? = nil

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: BookForm(createId: $createBookId), tag: createBookId ?? noIdTag, selection: $createBookId) {
                    EmptyView()
                }
                BookList(viewBookId: $viewBookId)
            }
            .navigationTitle("\(rootNavigationTitle)")
            .toolbar {
                Button(newBookTitle) {
                    createBookId = "25"
                }
            }
        }
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
