//
// This file is part of Canvas.
// Copyright (C) 2018-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import Foundation
@testable import Core
import TestsFoundation
import CoreData
import XCTest

public class TestEnvironment: AppEnvironment {
    override public init() {
        super.init()
        self.api = URLSessionAPI(loginSession: .make(), urlSession: MockURLSession())
        self.database = singleSharedTestDatabase
        self.globalDatabase = singleSharedTestDatabase
        self.router = TestRouter()
        self.logger = TestLogger()
    }

    override public func subscribe<U>(_ useCase: U, _ callback: @escaping Store<U>.EventHandler) -> Store<U> where U: UseCase {
        return TestStore(env: self, useCase: useCase, eventHandler: callback)
    }
}

public class TestStore<U: UseCase>: Store<U> {
    let refreshExpectation = XCTestExpectation(description: "Refresh")
    override public func refresh(force: Bool = false, callback: ((U.Response?) -> Void)? = nil) {
        refreshExpectation.fulfill()
    }

    let exhaustExpectation = XCTestExpectation(description: "Exhaust")
    override public func exhaust(while condition: @escaping (U.Response) -> Bool) {
        exhaustExpectation.fulfill()
    }

    let getNextPageExpectation = XCTestExpectation(description: "Next Page")
    override public func getNextPage(_ callback: ((U.Response?) -> Void)? = nil) {
        getNextPageExpectation.fulfill()
    }
}
