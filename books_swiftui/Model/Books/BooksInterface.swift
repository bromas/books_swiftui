//
//  BooksInterface.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/7/22.
//

import Foundation
import Combine

protocol BooksMutationInterface {
    func refreshBooks()
    func deleteBook(book: Book)
    func saveBook(book: Book)
}

class BooksInterface {

    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private let requestsResolver: BooksRequestResolver
    
    @Published var all: RemoteResult<[Book], Error> = .idle

    init(resolver: BooksRequestResolver) {
        requestsResolver = resolver
    }
    
}

extension BooksInterface: BooksMutationInterface {
    
    func refreshBooks() {
        requestsResolver.getBooks()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.all = .loading
            })
            .asRemoteResult()
            .receive(on: DispatchQueue.main, options: .none)
            .assign(to: &$all)
    }
    
    func deleteBook(book: Book) {
        requestsResolver
            .deleteBook(book: book)
            .asRemoteResult()
            .sink { _ in }
            .store(in: &bag)
    }
    
    func saveBook(book: Book) {
        requestsResolver
            .saveBook(book: book)
            .asRemoteResult()
            .sink { _ in }
            .store(in: &bag)
    }
    
}
