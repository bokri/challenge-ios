//
//  BankinTests.swift
//  BankinTests
//
//  Created by Aymen Bokri on 19/02/2022.
//

import XCTest
@testable import Bankin
import RxSwift
import OHHTTPStubs
import OHHTTPStubsSwift

class BankinTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    private var expectation: XCTestExpectation!
    private var httpStubsDescriptor: HTTPStubsDescriptor?
    
    override func setUp() {
        HTTPStubs.removeAllStubs()
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testSuccess() throws {
        MockBankingStorageManager.haveBanksValue = true
        self.expectation = expectation(description: "Test Success")
        
        MockBankinManager.fetchBanks()
            .subscribe {
                self.expectation.fulfill()
                XCTAssert(true)
            } onError: { _ in
                self.expectation.fulfill()
                XCTAssert(false)
            }.disposed(by: self.disposeBag)
        
        wait(for: [self.expectation], timeout: 10)
    }
    
    func testError() throws {
        MockBankingStorageManager.haveBanksValue = false
        self.expectation = expectation(description: "Test Error")
        
        MockBankinManager.fetchBanks()
            .subscribe {
                self.expectation.fulfill()
                XCTAssert(false)
            } onError: { error in
                self.expectation.fulfill()
                
                if case NetworkError.networkError = error  {
                    XCTAssert(true)
                } else {
                    XCTAssert(false)
                }
                
            }.disposed(by: self.disposeBag)
        
        wait(for: [self.expectation], timeout: 10)
    }

    func testDecodingSuccess() throws {
        self.expectation = expectation(description: "Tests Decoding Success")

        httpStubsDescriptor = stub(condition: isMethodGET()) { (_) -> HTTPStubsResponse in
            let stubPath = OHPathForFile("MockAPICallbackSuccess.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        BankinApiClient.getBanks(nextUri: nil)
            .subscribe { banksWrapper in
                self.expectation.fulfill()
                
                XCTAssert(banksWrapper.resources[0].id == 416)
                XCTAssert(banksWrapper.resources[0].name == "BNP Paribas Privée")
                XCTAssert(banksWrapper.resources[0].countryCode == "FR")
                XCTAssert(banksWrapper.resources[0].logoUrl == "https://web.bankin.com/img/banks-logo/france/12_BNPParisbasParticulier@2x.png")
            } onError: { error in
                self.expectation.fulfill()
                XCTAssert(false)
            }.disposed(by: self.disposeBag)


        wait(for: [self.expectation], timeout: 10)
    }
    
    func testDecodingError() throws {
        self.expectation = expectation(description: "Tests Decoding Error")

        httpStubsDescriptor = stub(condition: isMethodGET()) { (_) -> HTTPStubsResponse in
            let stubPath = OHPathForFile("MockAPICallbackError.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
            BankinApiClient.getBanks(nextUri: nil)
                .subscribe { banksWrapper in
                    self.expectation.fulfill()
                    XCTAssert(false)
                } onError: { error in
                    self.expectation.fulfill()

                    if case NetworkError.malformedJson = error {
                        XCTAssert(true)
                    } else {
                        XCTAssert(false)
                    }
                    
                }.disposed(by: self.disposeBag)

        wait(for: [self.expectation], timeout: 10)
    }
}
