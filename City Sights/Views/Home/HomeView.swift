//
//  Home.swift
//  City Sights
//
//  Created by Léa Dukaez on 10/09/2021.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false

    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                if !isMapShowing {
                    // Show list
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "mappin")
                            Text("Waterloo")
                            Spacer()
                            Button(action: {
                                print("map button clicked")
                                self.isMapShowing = true
                                
                            }, label: {
                                Text("Switch to Map View")
                            })
                            
                        }
                        Divider()
                        
                        BusinessList()
                        
                    }.accentColor(.black)
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                
                    
                } else {
                    // show map
                    BusinessMap().ignoresSafeArea()
                }
            }
        }
        
        else {
            // Still waiting for data so show spinner
            ProgressView()
        }
        
        

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
