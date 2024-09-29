//
//  Extensions.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import API

extension Double {
    /// Возвращает строку с двумя знаками после запятой
    func formattedToTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
}

extension ItemDTO {
    /// Создаёт мокированный экземпляр ItemDTO на основе предоставленного JSON-образца
    static func mockFromSample(
        description: String = "KHACHAPURI",
        quantity: Double = 1,
        unitPrice: Double = 22,
        amount: String = "22",
        vatPercentage: String = "8.00%",
        vatAmount: Double = 2,
        productType: String = "FOOD"
    ) -> ItemDTO {
        return ItemDTO(
            description: description,
            quantity: quantity,
            unitPrice: unitPrice,
            amount: amount,
            vatPercentage: vatPercentage,
            vatAmount: vatAmount,
            productType: productType
        )
    }
}

extension Date {
    /// Генерирует случайную дату между двумя заданными датами.
    /// - Parameters:
    ///   - from: Начальная дата диапазона.
    ///   - to: Конечная дата диапазона.
    /// - Returns: Случайная дата между `from` и `to`.
    static func random(from: Date = Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                      to: Date = Date()) -> Date {
        let interval = to.timeIntervalSince(from)
        let randomInterval = TimeInterval.random(in: 0...interval)
        return from.addingTimeInterval(randomInterval)
    }
    
    /// Генерирует случайную дату в пределах последних `days` дней.
    /// - Parameter days: Количество дней в прошлом, в пределах которых будет сгенерирована дата.
    /// - Returns: Случайная дата в пределах последних `days` дней.
    static func randomWithinLast(days: Int) -> Date {
        let from = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
        return Date.random(from: from, to: Date())
    }
}

extension TransactionDetailsDTO {
    /// Создаёт мокированный экземпляр TransactionDetailsDTO на основе предоставленного JSON-образца
    static func mockFromSample(
        purchasedAt: Date = /*ISO8601DateFormatter().date(from: "2024-09-28T14:28:33") ??*/ Date.randomWithinLast(days: 3),
        fiscalReceiptNumber: String = "0214",
        manufacturingNumber: String = "70001395"
    ) -> TransactionDetailsDTO {
        return TransactionDetailsDTO(
            purchasedAt: purchasedAt,
            fiscalReceiptNumber: fiscalReceiptNumber,
            manufacturingNumber: manufacturingNumber
        )
    }
}

extension ReceiptDTO {
    /// Создаёт мокированный экземпляр ReceiptDTO на основе предоставленного JSON-образца
    static func mockFromSample(receiptId: String = UUID().uuidString) -> ReceiptDTO {
        // Создание элементов (items) на основе JSON-образца
        let item1 = ItemDTO.mockFromSample(
            description: "KHACHAPURI",
            quantity: 1,
            unitPrice: 22,
            amount: "22",
            vatPercentage: "8.00%",
            vatAmount: 2,
            productType: "FOOD"
        )
        
        let item2 = ItemDTO.mockFromSample(
            description: "IZVORUL ALB 0.5 L",
            quantity: 1,
            unitPrice: 15,
            amount: "15",
            vatPercentage: "20.00%",
            vatAmount: 2.5,
            productType: "DRINKS"
        )
        
        let items = [item1, item2]
        
        // Создание деталей транзакции (transactionDetails) на основе JSON-образца
        let transactionDetails = TransactionDetailsDTO.mockFromSample()
        
        // Создание экземпляра ReceiptDTO
        return ReceiptDTO(
            companyName: "OLVIC-PRIM S.R.L.",
            fiscalCode: "1016600041755",
            address: "mun. Chisinau bd. Moscova, 6",
            registrationNumber: "J406005436",
            items: items,
            totalAmount: 37,
            paymentMethod: "NUMERAR",
            transactionDetails: transactionDetails,
            receiptId: receiptId // Уникальный идентификатор
        )
    }
    
    /// Создаёт массив мокированных чеков
    static func mockReceiptsFromSample(count: Int) -> [ReceiptDTO] {
        var receipts: [ReceiptDTO] = []
        for _ in 0..<count {
            let receipt = ReceiptDTO.mockFromSample()
            receipts.append(receipt)
        }
        return receipts
    }
}
