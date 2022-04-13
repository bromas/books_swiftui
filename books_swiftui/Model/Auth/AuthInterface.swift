//
//  AuthInterface.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/11/22.
//

import Foundation
import Combine

protocol AuthMutationInterface {
    func login(userName: String, password: String)
}

class AuthInterface {

    static let shared = AuthInterface()
    @Published var auth: RemoteResult<Authentication, Error> = .idle

}

extension AuthInterface: AuthMutationInterface {
    func login(userName: String, password: String) {
        auth = .loading
        Just(Authentication(expiration: Date().addingTimeInterval(90000), token: "abc123"))
            .setFailureType(to: Error.self)
            .delay(for: 1.5, tolerance: .none, scheduler: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
            .asRemoteResult()
            .receive(on: DispatchQueue.main, options: .none)
            .assign(to: &$auth)
    }
}
