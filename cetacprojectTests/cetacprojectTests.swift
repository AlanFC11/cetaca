//
//  cetacprojectTests.swift
//  cetacprojectTests
//
//  Created by user193544 on 10/10/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import XCTest
@testable import cetacproject


class cetacprojectTests: XCTestCase {

    var sut: Login!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = Login()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testFunctionTestName() throws {
        //given
        let name = "Ariondo Cruz"
        let id = "GVIMj0aos9eqgwB9pt01"
        //when
        let result = sut.updateName(id: id, name: name)
        //then
        XCTAssertNotNil(result)
        XCTAssertEqual(result, 1)
    }

}
