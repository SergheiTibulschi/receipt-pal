//
//  ReceiptView.swift
//  ScanUrCheck
//
//  Created by Dmitrii Sorochin on 28.09.2024.
//

import SwiftUI

struct ReceiptView: View {
    let receipt: ReceiptDTO = generateMockReceipts(count: 1)[0]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mimiPink.ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                Text(" \(receipt.companyName)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                Text("COD FISCAL: \(receipt.fiscalCode)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                Text("\(receipt.address)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                Text("REGISTRATION NUMBER: \(receipt.registrationNumber)")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
                
                Rectangle()
                    .stroke(style: .init(lineWidth: 1, dash: [2]))
                    .fill(.gray)
                    .frame(maxHeight: 1)
                
                    
                
                ForEach(receipt.items.indices) { index in
                    let item = receipt.items[index]
                    
                    HStack {
                        Text("\(index + 1) - ")
                        
                        Text("\(item.description)")
                        
                    Spacer()
                        
                        Text("\(item.quantity) x ")
                        +
                        Text("\(item.unitPrice.twoDecimalString)")
                    }
                }
            }
            .frame(maxWidth: .infinity)
           // .padding(.horizontal, 24)
            .padding(.top, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ReceiptView()
}
