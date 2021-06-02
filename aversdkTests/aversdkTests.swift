import XCTest
@testable import aversdk

final class AverSdkTests: XCTestCase {
    private var sdk: AverSdk!

    override func setUpWithError() throws {
        self.sdk = AverSdk()
        
        let asyncExpectation = expectation(description: "initApi")
        
        self.sdk.auth(key: "bf8d13db-3711-481a-9fbc-7b22b7ff8af9", secret:"NDMzNDkxNTkxOWE0MzBkNTc5NGQyOTg1YmNmZWQ4MDMwM2NkMzY0MzM0OTE=") { res, err in
            if(res != nil){
                print("Connected: " + res!)
                asyncExpectation.fulfill()
            }
        }

        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    override func tearDownWithError() throws {
        self.sdk = nil
    }

    func testCreateCheck() throws {
        let asyncExpectation = expectation(description: "testCreateCheck")
        var options: AverCheckCreateRequest
        var response: AverCheckCreateResponse?
        
        options = AverCheckCreateRequest(
            groupId: "1234",
            thirdPartyIdentifier: "1234",
            email: "someone@somewhere.com",
            returnUrl: "",
            language: "en",
            skipPersonalAccessCode: false,
            overrideThirdPartyIdentifier: false
        )
        
        self.sdk.createCheck(options: options) { res, err in
            response = res!
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }
    
    func testCreateCheckAccessCode() throws {
        let asyncExpectation = expectation(description: "testCreateCheckAccessCode")
        var response: AverCheckAccessLinkResponse?
        
        self.sdk.createCheckAccessLink(id: "1234") { res, err in
            response = res!
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }
    
    func testGetCheckById() throws {
        let asyncExpectation = expectation(description: "testGetCheckById")
        var response: AverCheckDetailResponse?
        
        self.sdk.getCheckById(id: "1234") { res, err in
            response = res!
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }
    
    func testGetCheckByThirdPartyIdentifier() throws {
        let asyncExpectation = expectation(description: "testGetCheckByThirdPartyIdentifier")
        var response: AverCheckDetailResponse?
        
        self.sdk.getCheckByThirdPartyIdentifier(thirdPartyIdentifier: "1234", all: true) { res, err in
            response = res!
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }
    
    func testGetCheckResults() throws {
        let asyncExpectation = expectation(description: "testGetCheckResults")
        var response: AverCheckDetailResponse?
        
        self.sdk.getCheckResults(id: "1234") { res, err in
            response = res!
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }
}

