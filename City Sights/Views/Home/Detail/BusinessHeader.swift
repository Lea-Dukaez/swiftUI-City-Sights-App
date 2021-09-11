//
//  BusinessHeader.swift
//  City Sights
//
//  Created by Léa Dukaez on 11/09/2021.
//

import SwiftUI

struct BusinessHeader: View {
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading) {
            // Details
            Text(business.name!)
                .font(.largeTitle)
            
            // Loop through display Adress
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            // Rating
            Image("regular_\(business.rating ?? 0.0)")
        }
    }
}

struct BusinessHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessHeader(business: Business.getTestData())
    }
}
