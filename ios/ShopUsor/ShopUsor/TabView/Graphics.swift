////
////  Graphics.swift
////  ShopUsor
////
////  Created by Dmitrii Sorochin on 29.09.2024.
////
//
import Foundation
import Charts
import SwiftUI
import API

enum Category: String {
    case food = "FOOD"
    case drinks = "DRINKS"
    case transport = "TRANSPORT"
    case kaif = "ENTERTAINMENT"
    case dom = "HOUSING"
    case jizn = "HEALTHCARE"
    case cigarets = "SMOKE"
    case cosmetics = "COSMETICS"
    
}

func getColorForCategory(category: String) -> Color {
    let _category = Category(rawValue: category)
    
    switch _category {
    case .food:
        return .green
    case .transport:
        return .blue
    case .kaif:
        return .orange
    case .dom:
        return .brown
    case .jizn:
        return .purple
    case .cigarets:
        return .gray
    case .cosmetics:
        return .pink
    case .drinks:
        return .blue
    case .none:
        return .yellow
    }
}
//
struct CategoryData: Identifiable {
    let id = UUID()
    let type: String
    let amount: Double
}
//
//@MainActor
final class CharViewModel: ObservableObject {
    @Published var receipts: [ReceiptDTO] = []
    
    func fetchData() {
        Task {
            do {
                let responce = try await DefaultAPI.getAllReceipts(page: 1, limit: 10).data ?? []
                await MainActor.run {
                    self.receipts = responce
                }
                print(receipts.count)
            } catch {
                print("error : \(error.localizedDescription)")
            }
        }
    }
    
    // Вычисляем общую сумму всех чеков
    var totalAmount: Double {
        receipts.reduce(0) { $0 + $1.totalAmount }
    }

    
    func calculateCategorySums(receipts: [ReceiptDTO]) -> [CategoryData] {
        var categorySet = Set<String>()
        var categorySums: [String: Double] = [:]
        
        for receipt in receipts {
            for item in receipt.items {
                let category = item.productType
                categorySet.insert(category)
                
                // Предполагаем, что сумма по категории считается как unitPrice * quantity
                let totalForItem = item.unitPrice * item.quantity
                
                if let currentSum = categorySums[category] {
                    categorySums[category] = currentSum + totalForItem
                } else {
                    categorySums[category] = totalForItem
                }
            }
        }
        
        return categorySums.map({ CategoryData(type: $0.key, amount: $0.value) })
    }
    
    var categorySums: [CategoryData] {
        calculateCategorySums(receipts: self.receipts)
    }
    
    var allCategoriesAmount: Double {
        calculateCategorySums(receipts: self.receipts).reduce(0) { partialResult, data in
            partialResult + data.amount
        }
    }
    
    // Преобразуем чеки в данные для диаграммы
    var chartData: [(receiptId: String, companyName: String, amount: Double)] {
        receipts.map { ($0.receiptId, $0.companyName, $0.totalAmount) }
    }

}

struct PieChartExampleView: View {
    @State private var selectedReceiptId: String? = nil
    @StateObject var viewModel = CharViewModel()
    
    let colorPalette: [Color] = [.blue, .green, .orange, .purple, .red, .yellow, .pink, .gray]
    
    var body: some View {
        VStack {
            Chart(viewModel.categorySums) { category in
                SectorMark(
                    angle: .value("Type", category.amount),
                    innerRadius: .ratio(0.6)
                )
                .foregroundStyle(getColorForCategory(category: category.type))
            }
            .frame(maxHeight: 250)
            .overlay(alignment: .center) {
                VStack(spacing: 0){
                    Text("Total spent:\n")
                        .font(.system(size: 16))
                    
                    Text("\(viewModel.allCategoriesAmount.formattedToTwoDecimals())")
                        .font(.system(size: 18))
                        .bold()
                }
            }
            
            
            VStack {
                ForEach(viewModel.categorySums) { category in
                    CategoryCell(category: category)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
                        .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
                }
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 26)
        .onAppear(perform: {
            viewModel.fetchData()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
        .navigationTitle("Charts")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
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

struct CategoryCell: View {
   // let image: ImageResource
    let category: CategoryData
    
    var body: some View {
        HStack(spacing: 19) {
            RoundedRectangle(cornerRadius: 12)
                .fill(getColorForCategory(category: category.type))
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(category.type)
                    .bold()
                    .font(.system(size: 14))
                
                Text("Total spent: \(category.amount.formattedToTwoDecimals()) MDL")
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PieChartExampleView()
}
