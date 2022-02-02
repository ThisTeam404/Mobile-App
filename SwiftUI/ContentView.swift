//
//  ContentView.swift
//  Shared
//
//  Created by Herrera, Anthony on 1/31/22.
//

import SwiftUI

struct ContentView: View {
    @State var numberOfLocks: String = ""
    @State var isOn = false
    @State var confirmFlag: Bool = false
    @State var cancelFlag: Bool = false
    var body: some View {
        ZStack{
            VStack{
                Text("LockThatDown").padding()
                HStack{
                    Spacer()
                    Button("Add Lock",action: {
                    print("Hello World")
                    })
                    Spacer()
                    Button("Create Job", action: {
                        print("Luigi")
                    })
                    Spacer()
                }
                HStack{
                    Text("Keyware Type").padding()
                    Spacer()
                    Button("One", action:{ print("One")})
                    Button("Two", action:{ print("Two")})
                    Button("Three", action:{ print("Three")})
                    Button("Four", action:{ print("Four")})
                    Spacer()
                }
                Text("Number of Locks:")
                TextField("Number", text: $numberOfLocks)
                HStack{
                    Spacer()
                    Button("Confirm",action: {
                    print("Hello World")
                    })
                    Spacer()
                    Button("Cancel", action: {
                        print("Luigi")
                    })
                    Spacer()
                }
                Toggle(isOn: $isOn) {
                    Text("Master Key?")
                    if(isOn)
                    {
                           Button("One", action:{ print("One")})
                           Button("Two", action:{ print("Two")})
                           Button("Three", action:{ print("Three")})
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    Button("Confirm",action: {
                        confirmFlag = true
                    }).alert(isPresented: $confirmFlag) {Alert(title: Text("Confirmation"), message: Text("Do you want to save the job information to the Add Lock page?"), primaryButton: .default(Text("Yes"), action: {print("Confirm test")}), secondaryButton: .cancel(Text("No")))}
                    Spacer()
                    Button("Cancel", action: {
                        cancelFlag = true
                    }).alert(isPresented: $cancelFlag) {Alert(title: Text("Cancel?"), message: Text("Do you want to delete your job information?"), primaryButton: .default(Text("Yes"), action: {print("Cancel test")}), secondaryButton: .cancel(Text("No")))}
                    Spacer()
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

