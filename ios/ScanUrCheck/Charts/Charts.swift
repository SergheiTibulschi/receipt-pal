//
//  Charts.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import Foundation
import SwiftUI
import Charts

func generateMockReceipts(count: Int) -> [ReceiptDTO] {
    return (0..<count).map { _ in generateRandomReceipt() }
}
struct PieChartExampleView: View {
    @State private var receipts: [ReceiptDTO] = generateMockReceipts(count: 4)
    @State private var selectedReceiptId: String? = nil
    
    // Вычисляем общую сумму всех чеков
    var totalAmount: Double {
        receipts.reduce(0) { $0 + $1.total.amount }
    }
    
    // Преобразуем чеки в данные для диаграммы
    var chartData: [(receiptId: String, companyName: String, amount: Double)] {
        receipts.map { ($0.id, $0.companyName, $0.total.amount) }
    }
    
    var body: some View {
        VStack {
            // Круговая диаграмма
            Chart(chartData, id: \.receiptId) { dataItem in
                SectorMark(
                    angle: .value("Amount", dataItem.amount),
                    innerRadius: .ratio(0.5),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .opacity(dataItem.receiptId == selectedReceiptId ? 1 : 0.5)
                .foregroundStyle(dataItem.receiptId == selectedReceiptId ? Color.green : .blue)
                .annotation(position: .overlay, alignment: .center) {
                    Text("\(String(format: "%.1f", (dataItem.amount / totalAmount) * 100))%")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .chartLegend(.hidden)
            .frame(height: 300)
            .padding()
            
            Divider()
            
            // Список чеков
            List(receipts) { receipt in
                VStack(alignment: .leading, spacing: 8) {
                    Text(receipt.companyName)
                        .font(.headline)
                    Text("Сумма: \(receipt.total.amount, specifier: "%.2f")")
                    Text("Дата: \(formattedDate(receipt.transactionDetails.date))")
                    Text("ID чека: \(receipt.transactionDetails.receiptId)")
                }
                .padding(.vertical, 4)
                .background(receipt.id == selectedReceiptId ? Color.green.opacity(0.3) : Color.clear)
                .cornerRadius(8)
                .onTapGesture {
                  //  withAnimation {
                        if selectedReceiptId == receipt.id {
                            selectedReceiptId = nil // Снять выделение, если уже выбран
                        } else {
                            selectedReceiptId = receipt.id
                        }
                   // }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    // Функция для форматирования даты
    func formattedDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }
}


#Preview {
    PieChartExampleView()
}


