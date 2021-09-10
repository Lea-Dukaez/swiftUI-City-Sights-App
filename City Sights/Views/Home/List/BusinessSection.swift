//
//  BusinessSection.swift
//  City Sights
//
//  Created by Léa Dukaez on 10/09/2021.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        Section (header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                BusinessCell(business: business)
                Divider()
            }
        }
        
    }
}

