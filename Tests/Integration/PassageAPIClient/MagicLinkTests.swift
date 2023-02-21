//
//  MagicLinkTests.swift
//  
//
//  Created by Kevin Flanagan on 2/16/23.
//
import XCTest
@testable import Passage

final class MagicLinkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        PassageSettings.shared.apiUrl = apiUrl
        PassageSettings.shared.appId = appInfoValid.id
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    @available(iOS 15.0, *)
    func testSendRegisterMagicLink() async {
        do {
            PassageAPIClient.shared.appId = appInfoValid.id
            let date = Date().timeIntervalSince1970
            let identifier = "authentigator" + "+" + String(date) + "@passage.id"
            let response = try await PassageAPIClient.shared.sendRegisterMagicLink(identifier: identifier, path: nil, language: nil)
            do {
                _ = try await PassageAPIClient.shared.magicLinkStatus(id: response.id)
                XCTAssertTrue(false) // the status should error as it is unactivated
            } catch {
                XCTAssertTrue(true)
            }
            
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testSendLoginMagicLink() async {
        do {
            PassageAPIClient.shared.appId = appInfoValid.id
            let response = try await PassageAPIClient.shared.sendLoginMagicLink(identifier: registeredUser.email!, path: nil, language: nil)
            do {
                _ = try await PassageAPIClient.shared.magicLinkStatus(id: response.id)
                XCTAssertTrue(false) // the status should error as it is unactivated
            } catch {
                XCTAssertTrue(true)
            }
        } catch {
            print(error)
            XCTAssertTrue(false)
        }
    }
    
    func testActivateMagicLink() async {
        do{
            PassageAPIClient.shared.appId = appInfoValid.id
            let date = Date().timeIntervalSince1970
            let identifier = "authentigator" + "+" + String(date) + "@ncor7c1m.mailosaur.net"
            let response = try await PassageAPIClient.shared.sendRegisterMagicLink(identifier: identifier, path: nil, language: nil)
            try await Task.sleep(nanoseconds: UInt64(3 * Double(NSEC_PER_SEC)))
            let magicLink = try await MailosaurAPIClient().getMostRecentMagicLink()
            let token = try await PassageAPIClient.shared.activateMagicLink(magicLink: magicLink)
            XCTAssertNotNil(token)
            do {
                _ = try await PassageAPIClient.shared.magicLinkStatus(id: response.id)
                XCTAssertTrue(true)
            } catch {
                XCTAssertTrue(false)
            }
        } catch {
            print(error)
        }
    }
}

