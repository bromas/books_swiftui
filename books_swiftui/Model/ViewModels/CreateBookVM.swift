//
//  CreateBookVM.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/7/22.
//

import Combine
import SwiftUI

class CreateBookVM: ObservableObject {
    
    @Published var save: RemoteResult<Book, Error> = .idle
    
    @Published var id: String = "10"
    @Published var coverlURL: String = ""
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var numberOfPages: String = ""
    
    @Published var publisher: BookPublisher = .other
    @Published var yearOfPublication: String = ""
    
    private let resolver: BooksRequestResolver
    
    init(resolver: BooksRequestResolver) {
        self.resolver = resolver
    }
    
    func removingLeadingZeros(string: String) -> String {
        string == "0" ? "" : string
    }
    
    func saveBook(book: Book) {
        save = .loading
        resolver
            .saveBook(book: book)
            .asRemoteResult()
            .receive(on: DispatchQueue.main, options: .none)
            .assign(to: &$save)
    }
}
