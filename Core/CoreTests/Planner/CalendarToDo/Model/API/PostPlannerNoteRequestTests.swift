//
// This file is part of Canvas.
// Copyright (C) 2024-present  Instructure, Inc.
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

import XCTest
@testable import Core

final class PostPlannerNoteRequestTests: XCTestCase {
    var req: PostPlannerNoteRequest!
    var date: Date = Clock.now

    override func setUp() {
        super.setUp()
        req = PostPlannerNoteRequest(body: PostPlannerNoteRequest.Body(title: "title", details: "details", todo_date: date, course_id: "1", linked_object_type: .planner_note, linked_object_id: "1"))
    }

    func testMethod() {
        XCTAssertEqual(req.method, .post)
    }

    func testPath() {
        XCTAssertEqual(req.path, "planner_notes")
    }

    func testBody() {
        XCTAssertEqual(req.body?.title, "title")
        XCTAssertEqual(req.body?.details, "details")
        XCTAssertEqual(req.body?.todo_date, date)
        XCTAssertEqual(req.body?.course_id, "1")
        XCTAssertEqual(req.body?.linked_object_type, .planner_note)
        XCTAssertEqual(req.body?.linked_object_id, "1")
    }
}
