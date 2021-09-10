//
//  BusinessSectionHeader.swift
//  City Sights
//
//  Created by Léa Dukaez on 10/09/2021.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title: String
    
    var body: some View {
        
        ZStack (alignment: .leading) {
            Rectangle()
                .frame(height: 48)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
        }
        
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "Restaurants")
    }
}
