//
//  GenericLoading.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/11/22.
//

import Foundation
import SwiftUI

struct GenericLoading: View {
    var body: some View {
        VStack {
            Text("Loading")
            ProgressView().progressViewStyle(.circular)
        }
    }
}


struct GenericLoading_Previews: PreviewProvider {
    static var previews: some View {
        GenericLoading()
    }
}
