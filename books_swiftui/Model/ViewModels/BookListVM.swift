//
//  AllBooksVM.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/7/22.
//

import Foundation
import Combine
import SwiftUI

class BookListVM: ObservableObject {
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private let interface: BooksMutationInterface
    
    @Published var books: RemoteResult<[Book], Error> = .idle
    
    init(interface: BooksMutationInterface, books: AnyPublisher<RemoteResult<[Book], Error>, Never>) {
        self.interface = interface
        books.sink { [weak self] in self?.books = $0 }.store(in: &bag)
    }
    
    func refreshBooks() {
        interface.refreshBooks()
    }
    
    func refreshBooksIfNeeded() {
        if books.isStale(timeInterval: 30) {
            interface.refreshBooks()
        }
    }
    
}
