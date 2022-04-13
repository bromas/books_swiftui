//
//  BookFormTextEntry.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/8/22.
//

import SwiftUI

struct BookFormTextEntry: View {
    
    let text: String
    let placeholder: String
    @Binding var input: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            TextField(placeholder, text: $input)
        }
    }
    
}

struct BookFormTextEntry_Previews: PreviewProvider {
    static var previews: some View {
        BookFormTextEntry(
            text: "Title: ",
            placeholder: "Dune",
            input: .constant("")
        ).border(Color.black, width: 1)
    }
}
