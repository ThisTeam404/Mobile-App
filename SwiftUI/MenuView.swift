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
                Spacer()
                
                Text("Menu").font(.largeTitle).bold().multilineTextAlignment(.trailing)
                
                NavigationLink(destination: createJob(), label: {
                    Text("Create Job")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                })
                
                NavigationLink(destination: AddLockView(), label: {
                    Text("Add Lock")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                })
                
                NavigationLink(destination: JobDetailsView(), label: {
                    Text("Job Details")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                })
                
                NavigationLink(destination: Text("Notes"), label: {
                    Text("Notes")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                })
                
                NavigationLink(destination: Text("Inventory"), label: {
                    Text("Inventory")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                })
                
                Spacer()
                
            }.navigationBarTitle("MENU")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("smilingLocksmith")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                        
                    }
                }
                .offset(x: 0, y: -50.0)
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


