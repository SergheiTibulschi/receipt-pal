//
//  RecieptView.swift
//  ShopUsor
//
//  Created by Dmitrii Sorochin on 29.09.2024.
//

import Foundation
import SwiftUI
import API
import CoreImage.CIFilterBuiltins
import NoughtyUI

func generateQr(code: String, scale: CGFloat = 10) -> UIImage {
    // Создаем контекст Core Image
    let context = CIContext()
    
    // Создаем фильтр QR-кода
    guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    // Устанавливаем сообщение для QR-кода
    filter.setValue(Data(code.utf8), forKey: "inputMessage")
    
    // Устанавливаем уровень коррекции ошибок (опционально)
    filter.setValue("M", forKey: "inputCorrectionLevel")
    
    // Получаем выходное изображение
    guard let outputImage = filter.outputImage else {
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    // Определяем масштабируемый коэффициент
    let transform = CGAffineTransform(scaleX: scale, y: scale)
    
    // Применяем масштабирование к изображению
    let scaledImage = outputImage.transformed(by: transform)
    
    // Создаем CGImage из CIImage
    guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else {
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    // Создаем UIImage из CGImage
    return UIImage(cgImage: cgImage)
}
// Структура для сгруппированного айтема
struct GroupedItem: Identifiable {
    let id = UUID()
    let description: String
    let unitPrice: Double
    let totalQuantity: Double
    let totalPrice: Double
}

// Функция для группировки элементов по описанию
func groupItems(items: [ItemDTO]) -> [GroupedItem] {
    // Группируем по description
    let groupedDictionary = Dictionary(grouping: items, by: { $0.description })
    
    // Преобразуем Dictionary в массив GroupedItem
    let groupedItems = groupedDictionary.compactMap { (key, values) -> GroupedItem? in
        // Проверяем, что все unitPrice одинаковы
        let uniqueUnitPrices = Set(values.map { $0.unitPrice })
        guard uniqueUnitPrices.count == 1, let unitPrice = uniqueUnitPrices.first else {
            // Если unitPrice различаются, можно выбрать, например, среднее или первую цену
            // Здесь мы пропустим такие группы, но вы можете изменить логику по необходимости
            return nil
        }
        
        let totalQuantity = values.reduce(0) { $0 + $1.quantity }
        let totalPrice = values.reduce(0) { $0 + ($1.unitPrice * $1.quantity) }
        
        return GroupedItem(description: key, unitPrice: unitPrice, totalQuantity: totalQuantity, totalPrice: totalPrice)
    }
    
    return groupedItems
}

struct RecieptView: View {
    let receipt: ReceiptDTO
    
    var uniqueProductTypes: [String] {
        Array(Set(receipt.items.map { $0.productType.lowercased() }))
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 2) {
                Text(receipt.companyName)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text("Fiscal code: \(receipt.fiscalCode)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text(receipt.address)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text("Registration number \(receipt.registrationNumber)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Line()
                    .stroke(style: .init(lineWidth: 1, dash: [2]))
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.top, 10)
                    .padding(.bottom, 12)
                
                ForEach(groupItems(items: receipt.items)) { item in
                    HStack(spacing: 0) {
                        Text("\(item.description)")
                        
                        Spacer()
                        
                        Text("\(item.totalQuantity.formattedToTwoDecimals()) x ")
                        
                        Text("\(item.unitPrice.formattedToTwoDecimals())")
                    }
                    .padding(.horizontal, 8)
                    .font(.system(size: 12))
                }
                
                Line()
                    .stroke(style: .init(lineWidth: 1, dash: [2]))
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.top, 10)
                    .padding(.bottom, 12)
                
                Text("Payment method: \(receipt.paymentMethod.lowercased())")
                    .font(.system(size: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("Total:")
                    
                    Spacer()
                    
                    Text("\(receipt.totalAmount.formattedToTwoDecimals())")
                }
                .padding(.top, 12)
                
                
                Line()
                    .stroke(style: .init(lineWidth: 1, dash: [2]))
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.top, 10)
                    .padding(.bottom, 12)
                
                Image(uiImage: generateQr(code: receipt.registrationNumber, scale: 5))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Line()
                    .stroke(style: .init(lineWidth: 1, dash: [2]))
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.top, 10)
                    .padding(.bottom, 12)
                
                Text("Purchase caregories")
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    ForEach(uniqueProductTypes, id: \.self) { item in
                        Text("\(item.lowercased())")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(hex: "#EDD2E0"))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundStyle(Color(hex: "#9A48D0"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 7)
                .padding(.leading)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: 2)
            .shadow(color: Color(hex: "#18396B0D").opacity(0.1), radius: 2, x: -2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.bottom, 30)
            .navigationTitle("Receipt View")
            .padding(.horizontal, 24)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
        }
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    RecieptView(receipt: .mockFromSample())
}
