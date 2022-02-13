//
//  createJob.swift
//  LockThatDown
//
//  Created by Herrera, Anthony on 2/9/22.
//

import SwiftUI

struct createJob: View {
    @Binding var changeView:Bool
    
    @State var flag = false
    @State var numberOfLocks: String = ""
    @State var isOn = false
    @State var confirmFlag: Bool = false
    @State var cancelFlag: Bool = false
    var body: some View {
        ZStack{
            VStack{
                Text("LockThatDown")
                HStack{
                    Spacer()
                    Button(action: {self.changeView = true}) {
                        Text("Add Page")
                    }
                    Spacer()
                    Button("Create Job", action:{ print("One two")})
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

    /*
struct createJob_Previews: PreviewProvider {
    static var previews: some View {
        createJob()
    }
}
*/
