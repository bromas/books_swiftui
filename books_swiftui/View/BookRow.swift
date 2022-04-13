//
//  BookRow.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/5/22.
//

import Foundation
import SwiftUI

enum BookRowStyle {
    static let title = Font.system(size: 21)
    static let detail = Font.system(size: 11)
}

struct BookRow: View {

    let book: Book

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://picsum.photos/60")) { image in
                image.resizable().aspectRatio(1.0, contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(minWidth: 50, maxWidth: 60, minHeight: 30, maxHeight: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(BookRowStyle.title)
                Text(book.author)
                    .font(BookRowStyle.detail)
                Text("Year of publication: \(book.publicationYear)")
                    .font(BookRowStyle.detail)
                Text("Number of pages: \(book.numberOfPages)")
                    .font(BookRowStyle.detail)
            }
        }
    }

}


struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
