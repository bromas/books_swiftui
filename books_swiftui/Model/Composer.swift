//
//  DependencyResolver.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/11/22.
//

import Foundation

class Composer {
    
    static let shared = Composer()
    
    let authInterface: AuthInterface
    
    let booksResolver: BooksRequestResolver
    let booksInterface: BooksInterface
    
    init() {
        authInterface = AuthInterface()
        booksResolver = BooksMockResolver()
        booksInterface = BooksInterface(resolver: BooksMockResolver())
    }
    
    func buildLoginVM() -> LoginVM {
        LoginVM(interface: authInterface, auth: authInterface.$auth.eraseToAnyPublisher())
    }
    
    func buildBookListVM() -> BookListVM {
        BookListVM(interface: booksInterface, books: booksInterface.$all.eraseToAnyPublisher())
    }
    
    func createBook() -> CreateBookVM {
        CreateBookVM(resolver: booksResolver)
    }
    
}
