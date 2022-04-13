//
//  BookList.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/7/22.
//

import Combine
import SwiftUI

struct BookList: View {

    @StateObject var vm: BookListVM = Composer.shared.buildBookListVM()
    @Binding var viewBookId: String?

    @State private var emptyBooks: [Book] = []

    var body: some View {
        ZStack {
            switch vm.books {
                case let .success(_, books):
                    List(books, id: \.id) { book in
                        NavigationLink(destination: Text("with tag: \(book.id)"), tag: "\(book.id)", selection: $viewBookId) {
                            BookRow(book: book)
                        }
                    }
                default:
                    List(emptyBooks, id: \.id) { _ in EmptyView() }
                    GenericLoading()
            }
        }.onAppear {
            vm.refreshBooksIfNeeded()
        }
    }

}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
