//
//  LoginVM.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/11/22.
//

import Foundation
import Combine
import SwiftUI

class LoginVM: ObservableObject {
    
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    private let interface: AuthMutationInterface
    
    @Published var auth: RemoteResult<Authentication, Error> = .idle
    
    init(interface: AuthMutationInterface, auth: AnyPublisher<RemoteResult<Authentication, Error>, Never>) {
        self.interface = interface
        auth.sink { [weak self] in self?.auth = $0 }.store(in: &bag)
    }
    
    func login(userName: String, password: String) {
        interface.login(userName: userName, password: password)
    }
}
