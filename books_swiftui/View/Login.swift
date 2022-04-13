//
//  Login.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/11/22.
//

import Foundation
import SwiftUI

private let rootNavigationTitle = "Books"
private let newBookTitle = "create"
private let noIdTag = "missingBookId"

struct Login: View {
    
    @ObservedObject var vm: LoginVM
    
    @AppStorage("username") private var userName: String = ""
    @AppStorage("password") private var password: String = ""

    var body: some View {
        VStack(spacing: 12) {
            Text("Welcome back")
            HStack {
                Text("username: ")
                    .foregroundColor(Color.gray)
                TextField("Username", text: $userName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            HStack {
                Text("password: ")
                    .foregroundColor(Color.gray)
                SecureField("Password", text: $password).autocapitalization(.none)
            }
            Button("click to login") {
                vm.login(userName: "", password: "")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
    }

}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(vm: LoginVM(interface: AuthInterface(), auth: AuthInterface().$auth.eraseToAnyPublisher()))
    }
}
