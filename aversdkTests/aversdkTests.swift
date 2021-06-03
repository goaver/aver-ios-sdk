import XCTest
@testable import aversdk

final class AverSdkTests: XCTestCase {
    private var sdk: AverSdk!

    override func setUpWithError() throws {
        self.sdk = AverSdk()
        
        let asyncExpectation = expectation(description: "initApi")
        
        let res = self.sdk.auth(key: "bf8d13db-3711-481a-9fbc-7b22b7ff8af9", secret:"NDMzNDkxNTkxOWE0MzBkNTc5NGQyOTg1YmNmZWQ4MDMwM2NkMzY0MzM0OTE=")
        switch res {
            case .success(_):
                print("aversdktests: Setup successful")
            case .failure(let error):
                throw(error)
        }
        asyncExpectation.fulfill()
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    override func tearDownWithError() throws {
        self.sdk = nil
    }

    func testCreateCheck() throws {
        let asyncExpectation = expectation(description: "testCreateCheck")
        let options:AverCheckCreateRequest = AverCheckCreateRequest(
            groupId: "1234",
            thirdPartyIdentifier: "1234",
            email: "someone@somewhere.com",
            returnUrl: "",
            language: AverLanguage.english,
            skipPersonalAccessCode: false,
            overrideThirdPartyIdentifier: false,
            supplementalDocumentTypes: [AverCheckSupplementalDocumentType.medicalCard],
            watchlistSearchCategories: [AverWatchlistSearchCategory.financial],
            watchlistRecheckInterval: AverWatchlistSearchRecheckInterval.daily
        )
        
        let result =  try self.sdk.createCheck(options: options)
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testGetCheckAccessCode() throws {
        let asyncExpectation = expectation(description: "testGetCheckAccessCode")
        
        let result = try self.sdk.getCheckAccessLink(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testAddCheckPersonalInfo() throws {
        let asyncExpectation = expectation(description: "testAddCheckPersonalInfo")
        
        let options: AverCheckPersonalInformationRequest = AverCheckPersonalInformationRequest(
            email: "some@user.com",
            firstName: "Some",
            middleName: nil,
            lastName: "Person",
            gender: "M",
            dateOfBirth: "01/01/1980",
            stateProvince: "CA",
            country: "US",
            streetAddress1: "1234 Some Street",
            streetAddress2: nil,
            city: "Los Angeles",
            postalCode: "90001")
        
        let result = try self.sdk.addCheckPersonalInfo(id: "1234", options: options)
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            switch result {
                case .failure(_):
                    XCTFail("Failed")
                case .success(_):
                    print("Success")
            }
        }
    }
    
    func testAddCheckIdDocument() throws {
        let asyncExpectation = expectation(description: "testAddCheckIdDocument")
        
        let options: AverCheckIdDocumentRequest = AverCheckIdDocumentRequest (
            docType: AverCheckDocumentType.naDriverLicense,
            side: AverCheckDocumentSide.front,
            fileName: "somefile.jpg",
            fileContent: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAACJQAAAcVCAYAAADftBhiAAAAAXNSR0IB2cksf..."
        )
        
        let result = try self.sdk.addCheckIdDocument(id: "1234", options: options)
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            switch result {
                case .failure(_):
                    XCTFail("Failed")
                case .success(_):
                    print("Success")
            }
        }
    }
    
    func testAddCheckPhoto() throws {
        let asyncExpectation = expectation(description: "testAddCheckPhoto")
        
        let options: AverCheckPhotoRequest = AverCheckPhotoRequest(
            fileName: "somefile.jpg",
            fileContent: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAACJQAAAcVCAYAAADftBhiAAAAAXNSR0IB2cksf...",
            forceCommit: false
        )
        
        let result = try self.sdk.addCheckPhoto(id: "1234", options: options)
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            switch result {
                case .failure(_):
                    XCTFail("Failed")
                case .success(_):
                    print("Success")
            }
        }
    }
    
    func testAddCheckSupplementalDocument() throws {
        let asyncExpectation = expectation(description: "testAddCheckSupplementalDocument")
        
        let options: AverCheckSupplementalDocumentRequest = AverCheckSupplementalDocumentRequest(
            docType: AverCheckSupplementalDocumentType.medicalCard,
            fileName: "somefile.jpg",
            fileContent: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAACJQAAAcVCAYAAADftBhiAAAAAXNSR0IB2cksf..."
        )
        
        let result = try self.sdk.addCheckSupplementalDocument(id: "1234", options: options)
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            switch result {
                case .failure(_):
                    XCTFail("Failed")
                case .success(_):
                    print("Success")
            }
        }
    }
    
    func testSubmitCheck() throws {
        let asyncExpectation = expectation(description: "testSubmitCheck")
        let result = try self.sdk.submitCheck(id: "1234")
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            switch result {
                case .failure(_):
                    XCTFail("Failed")
                case .success(_):
                    print("Success")
            }
        }
    }
    
    func testGetCheckById() throws {
        let asyncExpectation = expectation(description: "testGetCheckById")
        
        let result = try self.sdk.getCheckById(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testGetCheckByThirdPartyIdentifier() throws {
        let asyncExpectation = expectation(description: "testGetCheckByThirdPartyIdentifier")
    
        let result = try self.sdk.getCheckByThirdPartyIdentifier(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testGetCheckResults() throws {
        let asyncExpectation = expectation(description: "testGetCheckResults")

        let result = try self.sdk.getCheckResults(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testCreateWatchlistSearch() throws {
        let asyncExpectation = expectation(description: "testCreateWatchlistSearch")
        let options:AverWatchlistSearchRequest = AverWatchlistSearchRequest(
            groupId: "1234",
            firstName: "Test",
            middleName: nil,
            lastName: "User",
            businessName: nil,
            country: "US",
            stateOrProvince: "CA",
            categories: [AverWatchlistSearchCategory.criminal, AverWatchlistSearchCategory.financial]
        )

        let result = try self.sdk.createWatchlistSearch(options: options)
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testGetWatchlistSearchById() throws {
        let asyncExpectation = expectation(description: "testGetWatchlistSearchById")

        let result = try self.sdk.getWatchlistSearchById(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testGetWatchlistSearchByCheckId() throws {
        let asyncExpectation = expectation(description: "testGetWatchlistSearchByCheckId")

        let result = try self.sdk.getWatchlistSearchByCheckId(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
    
    func testGetWatchlistSearchResults() throws {
        let asyncExpectation = expectation(description: "testGetWatchlistSearchResults")

        let result = try self.sdk.getWatchlistSearchResults(id: "1234")
        let value = try result.get()
        asyncExpectation.fulfill()
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNotNil(value)
        }
    }
}

