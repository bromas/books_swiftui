//
//  ContentView.swift
//  books_macOS
//
//  Created by Brian Thomas on 4/12/22.
//

// Just for demo purposes.
import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    @StateObject private var loginVM = Composer.shared.buildLoginVM()
    
    var body: some View {
        ZStack {
            switch loginVM.auth {
                case .success(_, _):
                    Main()
                case .loading:
                    GenericLoading()
                default:
                Button("Login") {
                    loginVM.login(userName: "", password: "")
                }
            }
        }.frame(width: 600, height: 500, alignment: .center)
    }
}

struct Main: View {
    
    @State private var viewBookId: String? = nil
    @State private var createBookId: String? = nil

    var body: some View {
        NavigationView {
            BookList(viewBookId: $viewBookId)
        }
        .navigationTitle("Books")
        .toolbar {
            Button("Create a book") {
                createBookId = "25"
            }
        }
    }
    
}

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
                            Text("book.")
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
