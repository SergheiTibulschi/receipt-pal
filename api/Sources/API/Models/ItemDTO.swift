//
// ItemDTO.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ItemDTO: Codable, JSONEncodable, Hashable {

    public var description: String
    public var quantity: Double
    public var unitPrice: Double
    public var amount: String
    public var vatPercentage: String
    public var vatAmount: Double

    public init(description: String, quantity: Double, unitPrice: Double, amount: String, vatPercentage: String, vatAmount: Double) {
        self.description = description
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.amount = amount
        self.vatPercentage = vatPercentage
        self.vatAmount = vatAmount
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case description
        case quantity
        case unitPrice
        case amount
        case vatPercentage
        case vatAmount
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(unitPrice, forKey: .unitPrice)
        try container.encode(amount, forKey: .amount)
        try container.encode(vatPercentage, forKey: .vatPercentage)
        try container.encode(vatAmount, forKey: .vatAmount)
    }
}

