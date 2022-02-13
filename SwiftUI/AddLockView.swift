//
//  AddLockView.swift
//  LockThatDown
//
//  Created by Milford Gover on 2/13/22.
//

import SwiftUI

struct AddLockView: View {
    @Binding var changeView:Bool
    
    @State var lockPins: String = ""
    @State var isOn = false
    @State var jobDate: String = ""
    @State var jobName: String = ""
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
                    Button(action:{ self.changeView=false}) {
                        Text("Create Job")
                    }
                    Spacer()
                }
                HStack{
                    Text("Keyway Type").padding()
                    Spacer()
                    Button("Schlage", action:{ print("Schlage")})
                    Button("Kwikset", action:{ print("Kwikset")})
                    Spacer()
                }
                Text("Lock Combo:")
                TextField("Combo: ", text: $lockPins)
                HStack{
                    Spacer()
                    Button("Confirm",action: {
                    print("Combo Added")
                    })
                    Spacer()
                }
                Toggle(isOn: $isOn) {
                    Text("Additional Info?")
                    if(isOn)
                    {
                        VStack{
                            HStack{
                                Spacer()
                                Text("Job Name:")
                                Spacer()
                                TextField("Name ", text: $jobName)
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                Text("Job Date:")
                                Spacer()
                                TextField("Date ", text: $jobDate)
                                Spacer()
                            }
                        }
                    }
                }
                
                
                
            }
        }
    }
}

/*
struct AddLockView_Previews: PreviewProvider {
    static var previews: some View {
        AddLockView()
    }
}
 */
