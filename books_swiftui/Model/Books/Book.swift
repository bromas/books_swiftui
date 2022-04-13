//
//  BooksDataManager.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/6/22.
//

import Foundation
import Combine

struct Book: Hashable {
    let id: Int
    let coverURL: String
    let title: String
    let author: String
    let numberOfPages: String
    let publicationYear: String
    let isAvailable: Bool = false
    let rating: Double = 3.45
    let publisher: BookPublisher = .other
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum BookPublisher: String, Equatable, CaseIterable {
    
    case randomHouse = "Random House"
    case hachetteBookGroup = "Hachette Book Group"
    case harperCollins = "Harper Collins"
    case simonAndSchuster = "Simon and Schuster"
    case macmillan = "MacMillan"
    case scribner = "Scribner"
    case other = "Other"
    
    var localizedName: String { rawValue }
    
}
