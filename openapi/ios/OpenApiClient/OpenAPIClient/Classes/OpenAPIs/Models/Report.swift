//
// Report.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Report: Codable, JSONEncodable, Hashable {

    public var id: Int64?
    public var text: String?

    public init(id: Int64? = nil, text: String? = nil) {
        self.id = id
        self.text = text
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case text
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(text, forKey: .text)
    }
}
