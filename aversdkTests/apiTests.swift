import XCTest
@testable import aversdk

final class ApiTests: XCTestCase {
    private var api: AverApi!
    private var key: String?
    private var secret: String?
    private var token: String?

    override func setUpWithError() throws {
        let baseUrl = "http://192.168.1.154:51036/api"
        self.key = "bf8d13db-3711-481a-9fbc-7b22b7ff8af9"
        self.secret = "NDMzNDkxNTkxOWE0MzBkNTc5NGQyOTg1YmNmZWQ4MDMwM2NkMzY0MzM0OTE="
        
        self.api = AverApi(baseUrl: baseUrl)
        try self.getAuthToken()
    }
    
    override func tearDownWithError() throws {
        self.api = nil
    }

    private func getAuthToken() throws {
        let asyncExpectation = expectation(description: "testGetAuthToken")
        var token: String?

        self.api.getAuthToken(key: self.key!, secret: self.secret!) { authToken, authErr in
            token = authToken
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            if(token != nil){
                self.token = token
                print("Token: " + token!)
            }
        }
    }
    
    func testRefreshAuthToken() throws {
        let asyncExpectation = expectation(description: "testRefreshAuthToken")
        var token: String?

        self.api.refreshAuthToken(token: self.token!) { authToken, authErr in
            token = authToken
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(token)
            XCTAssertNil(error)
        }
    }
    
    func testEncodeKey() throws {
        let encoded = self.api.encodeKey(key:"Test", secret:"Value")
        print("Encoded: " + encoded!)
        XCTAssertEqual("VGVzdDpWYWx1ZQ==", encoded)
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
        
        self.api.createCheck(token: self.token!, options: options) { res, err in
            print(err)
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
        
        self.api.createCheckAccessLink(token: self.token!, id: "1234") { res, err in
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
        
        self.api.getCheckById(token: self.token!, id: "1234") { res, err in
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
        
        self.api.getCheckByThirdPartyIdentifier(token: self.token!, thirdPartyIdentifier: "1234", all: true) { res, err in
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
        
        self.api.getCheckResults(token: self.token!, id: "1234") { res, err in
            response = res!
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
        }
    }
}

