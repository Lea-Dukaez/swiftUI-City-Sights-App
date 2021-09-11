//
//  BusinessDetail.swift
//  City Sights
//
//  Created by Léa Dukaez on 10/09/2021.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    @State private var showDirections = false
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }.ignoresSafeArea(.all, edges: .top)
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white).padding(.leading)
                }
            }


            Group {
                
                BusinessHeader(business: business).padding()
                
                Divider()
                
                // Phone
                HStack {
                    Text("Phone:").bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                
                Divider()
                
                // Reviews
                HStack {
                    Text("Reviews:").bold()
                    Text("\(business.reviewCount ?? 0)")
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
                
                // Website
                HStack {
                    Text("Website:").bold()
                    Text(business.url ?? "").lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
            }
            
            // Get Directions button
            Button(action: {
                
                // Show directions
                self.showDirections = true
                // Use the Sheet modifyer
                
                
            }, label: {
                ZStack (alignment: .center) {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white).bold()
                }
            }).padding()
            .sheet(isPresented: $showDirections) {
                DirectionsView(business: business)
            }

            
        }
    }
}

struct BusinessDetail_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetail(business: Business.getTestData())
    }
}
