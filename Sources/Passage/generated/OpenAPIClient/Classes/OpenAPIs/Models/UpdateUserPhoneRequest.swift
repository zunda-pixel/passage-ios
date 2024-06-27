//
// UpdateUserPhoneRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct UpdateUserPhoneRequest: Codable, JSONEncodable, Hashable {

    /** language of the email to send (optional) */
    public var language: String?
    public var magicLinkPath: String?
    public var newPhone: String?
    public var redirectUrl: String?

    public init(language: String? = nil, magicLinkPath: String? = nil, newPhone: String? = nil, redirectUrl: String? = nil) {
        self.language = language
        self.magicLinkPath = magicLinkPath
        self.newPhone = newPhone
        self.redirectUrl = redirectUrl
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case language
        case magicLinkPath = "magic_link_path"
        case newPhone = "new_phone"
        case redirectUrl = "redirect_url"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(magicLinkPath, forKey: .magicLinkPath)
        try container.encodeIfPresent(newPhone, forKey: .newPhone)
        try container.encodeIfPresent(redirectUrl, forKey: .redirectUrl)
    }
}
