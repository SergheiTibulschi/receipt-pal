//
//  Models.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import Foundation

struct ReceiptDTO: Identifiable {
    var id: String {
        transactionDetails.receiptId
    }
    let companyName: String
    let fiscalCode: String
    let address: String
    let registrationNumber: String
    let items: [ItemDTO]
    let total: TotalDTO
    let transactionDetails: TransactionDetailsDTO
}

struct ItemDTO: Identifiable {
    let id = UUID()
    let description: String
    let quantity: Int
    let unitPrice: Double
    let amount: String
}

struct TotalDTO {
    let amount: Double
    let vat: [VatDetailDTO]
    let paymentMethod: String
}

struct VatDetailDTO {
    let percentage: String
    let amount: Double
}

struct TransactionDetailsDTO {
    let date: String
    let time: String
    let fiscalReceiptNumber: String
    let manufacturingNumber: String
    let receiptId: String
}

extension TransactionDetailsDTO {
    var dateAsDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Формат даты в строке
        return formatter.date(from: date)
    }
}

func generateRandomReceipt() -> ReceiptDTO {
    let companyNames = ["ABC Store", "XYZ Market", "Fresh Goods"]
    let addresses = ["123 Main St, Springfield", "456 Elm St, Rivertown", "789 Oak St, Newville"]
    let paymentMethods = ["Credit Card", "Cash", "Debit Card"]
    
    let randomCompanyName = companyNames.randomElement() ?? "Unknown Store"
    let randomFiscalCode = UUID().uuidString.prefix(10)
    let randomAddress = addresses.randomElement() ?? "Unknown Address"
    let randomRegistrationNumber = UUID().uuidString.prefix(9)
    
    let randomItems = (1...Int.random(in: 1...5)).map { _ in
        ItemDTO(
            description: "Product \(Int.random(in: 1...100))",
            quantity: Int.random(in: 1...10),
            unitPrice: Double.random(in: 5.0...100.0),
            amount: String(format: "%.2f", Double.random(in: 10.0...500.0))
        )
    }
    
    let totalAmount = Double.random(in: 0...2000)
    let vatDetails = [
        VatDetailDTO(percentage: "\(Int.random(in: 5...20))%", amount: totalAmount * 0.1)
    ]
    
    let randomTotal = TotalDTO(
        amount: totalAmount,
        vat: vatDetails,
        paymentMethod: paymentMethods.randomElement() ?? "Unknown Method"
    )
    
    let randomTransactionDetails = TransactionDetailsDTO(
        date: "28/09/2024",
        time: String(format: "%02d:%02d", Int.random(in: 0...23), Int.random(in: 0...59)),
        fiscalReceiptNumber: UUID().uuidString.prefix(8).description,
        manufacturingNumber: UUID().uuidString.prefix(8).description,
        receiptId: UUID().uuidString.prefix(12).description
    )
    
    return ReceiptDTO(
        companyName: randomCompanyName,
        fiscalCode: String(randomFiscalCode),
        address: randomAddress,
        registrationNumber: String(randomRegistrationNumber),
        items: randomItems,
        total: randomTotal,
        transactionDetails: randomTransactionDetails
    )
}

extension Double {
    /// Возвращает строку, представляющую число с двумя десятичными знаками.
    var twoDecimalString: String {
        String(format: "%.2f", self)
    }
    
    /// Метод для получения строки с двумя десятичными знаками.
    func toTwoDecimalString() -> String {
        String(format: "%.2f", self)
    }
}
