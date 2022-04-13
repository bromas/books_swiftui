//
//  BookForm.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/5/22.
//

import SwiftUI

struct BookForm: View {

    // This binding is our handle to navigation popping the form
    @StateObject var createVM: CreateBookVM = Composer.shared.createBook()
        
    @Binding var createId: String?

    @State var rating: Float = 0.0
    @State var date: Date = Date()

    var body: some View {
        ZStack {
            switch createVM.save {
                case .idle, .success:
                    Form {
                        Section(header: Text("Book Details")) {
                            BookFormTextEntry(
                                text: "Title:",
                                placeholder: "Watership Down",
                                input: $createVM.title
                            )
                            BookFormTextEntry(
                                text: "Author:",
                                placeholder: "Richard Adams",
                                input: $createVM.author
                            )
                            BookFormTextEntry(
                                text: "Number of pages:",
                                placeholder: "476",
                                input: $createVM.numberOfPages
                            ).onChange(of: createVM.numberOfPages, perform: { newValue in
                                createVM.numberOfPages = createVM
                                    .removingLeadingZeros(string: newValue)
                            }).keyboardType(.numberPad)
                        }
                        
                        Section(header: Text("Published")) {
                            Picker(selection: $createVM.publisher, content: {
                                ForEach(BookPublisher.allCases, id: \.self) { value in
                                    Text(value.localizedName).tag(value)
                                }
                            }, label: {
                                Text("Publisher")
                            })
                            DatePicker(selection: $date, label: { Text("Date") })
                        }
                        
                        
                        Button("Save") {
                            createVM.saveBook(
                                book: Book(
                                    id: 0,
                                    coverURL: "",
                                    title: "",
                                    author: "",
                                    numberOfPages: "",
                                    publicationYear: ""
                                )
                            )
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Create")
                default:
                    GenericLoading()
            }
        }.onChange(of: createVM.save) { newValue in
            if case .success = newValue {
                createId = .none
            }
        }
    }
}


struct BookForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookForm(createVM: CreateBookVM(resolver: BooksMockResolver()), createId: .constant("3"))
        }
    }
}
