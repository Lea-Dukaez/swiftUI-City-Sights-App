//
//  BusinessCell.swift
//  City Sights
//
//  Created by Léa Dukaez on 10/09/2021.
//

import SwiftUI

struct BusinessCell: View {
    
    @ObservedObject var business: Business

    var body: some View {

            HStack {
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58, alignment: .center)
                    .cornerRadius(5)
                    .scaledToFit()

                VStack (alignment: .leading, spacing: 10) {
                    Text(business.name ?? "").bold()
                    Text(String(format: "%.1f km away", (business.distance ?? 0)/1000)).font(.caption)
                }
                Spacer()
                VStack {
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews").font(.caption)
                }
            }
    }
}

struct BusinessCell_Previews: PreviewProvider {
    static var previews: some View {

        BusinessCell(business: Business.getTestData())
    }
}
