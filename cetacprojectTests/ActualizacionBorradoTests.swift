//
//  ActualizacionTests.swift
//  cetacprojectTests
//
//  Created by user193544 on 10/10/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import XCTest
@testable import cetacproject

class ActualizacionBorradoTests: XCTestCase {

    var sut: Login!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = Login()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testFunctionTestUpdateName() throws {
        //given
        let name = "Ariondo Cruz"
        let id = "GVIMjOaos9eqgwB9pt01"
        //when
        let result = sut.updateName(id: id, name: name)
        //then
        XCTAssertEqual(result, 1)
    }
    
    func testFunctionTestUpdatePassword() throws {
        //given
        let password = "password1243"
        let id = "GVIMjOaos9eqgwB9pt01"
        //when
        let result = sut.updatePassword(id: id, password: password)
        //then
        XCTAssertEqual(result, 1)
    }
    
    func testFunctionTestDeleteSubadmin() throws {
        //given
        let id = "GVIMj0aos9eqgwB9pt01" // "Ts8abjB0JiMczuCRd93f", "RQjY0I3rF1CJJeT63ABT", "MopNjldYbZSIsX749uEo" ids for test cases when other is used as the document is deleted in the database
        //when
        let result = sut.deleteUser(id: id)
        //then
        XCTAssertEqual(result, 1)
    }



}
