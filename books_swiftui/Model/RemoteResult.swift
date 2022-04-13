//
//  RemoteRequest.swift
//  books_swiftui
//
//  Created by Brian Thomas on 4/6/22.
//

import Foundation
import Combine

enum RemoteResult<T,E: Error>: Equatable {
    
    case idle
    case loading
    case error(E)
    case success(Date, T)
    
    func isStale(timeInterval: TimeInterval) -> Bool {
        switch self {
            case let .success(date, _):
                return date.addingTimeInterval(timeInterval).compare(Date()) == .orderedAscending
            default:
                return true
        }
    }
}

extension Publisher {

    func asRemoteResult() -> AnyPublisher<RemoteResult<Output, Failure>, Never> {
        map {
            RemoteResult<Output, Failure>.success(Date(), $0)
        }
        .catch { error -> AnyPublisher<RemoteResult<Output, Failure>, Never> in
            Just(RemoteResult<Output, Failure>.error(error)).eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

}

extension RemoteResult {
    static func == (lhs: Self, rhs: Self) -> Bool {
        if case .idle = lhs {
            if case .idle = rhs {
                return true
            }
        }
        if case .loading = lhs {
            if case .loading = rhs {
                return true
            }
        }
        if case .error = lhs {
            if case .error = rhs {
                return true
            }
        }
        if case .success(let lhs_date, _) = lhs {
            if case .success(let rhs_date, _) = rhs {
                return rhs_date.compare(lhs_date) == .orderedSame
            }
        }
        return false
    }
}
