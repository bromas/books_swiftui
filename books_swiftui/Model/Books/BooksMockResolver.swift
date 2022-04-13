//
//  BooksMockResolver.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/7/22.
//

import Foundation
import Combine

protocol BooksRequestResolver {
    func getBooks() -> AnyPublisher<[Book], Error>
    func saveBook(book: Book) -> AnyPublisher<Book, Error>
    func deleteBook(book: Book) -> AnyPublisher<(), Error>
}

private let sampleBooks = [
    Book(id: 0, coverURL: "https://picsum.photos/60", title: "one", author: "me", numberOfPages: "20", publicationYear: "2018"),
    Book(id: 1, coverURL: "https://picsum.photos/60", title: "two", author: "me", numberOfPages: "20", publicationYear: "2018"),
    Book(id: 2, coverURL: "https://picsum.photos/60", title: "three", author: "me", numberOfPages: "20", publicationYear: "2018"),
    Book(id: 3, coverURL: "https://picsum.photos/60", title: "four", author: "me", numberOfPages: "20", publicationYear: "2018")
]

class BooksMockResolver: BooksRequestResolver {
    func saveBook(book: Book) -> AnyPublisher<Book, Error> {
        Just(book)
            .setFailureType(to: Error.self)
            .delay(for: 1.5, tolerance: .none, scheduler: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }
    
    func deleteBook(book: Book) -> AnyPublisher<(), Error> {
        Just<Void>(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getBooks() -> AnyPublisher<[Book], Error> {
        Just(sampleBooks)
            .setFailureType(to: Error.self)
            .delay(for: 1.5, tolerance: .none, scheduler: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }
}
