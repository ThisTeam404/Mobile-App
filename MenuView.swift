//
//  MenuView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/24/22.
//

import SwiftUI

struct MenuView: View {
    
    @State private var changeView = false
    
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: CreateJobView(), label: {
                    Text("Create Job")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                })
                NavigationLink(destination: Text("Add Lock"), label: {
                    Text("Add Lock")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                })
            }.navigationTitle("Menu")
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


