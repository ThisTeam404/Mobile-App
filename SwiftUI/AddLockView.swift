//
//  AddLockView.swift
//  LockThatDown
//
//  Created by Milford Gover on 2/13/22.
//

import SwiftUI

struct Lock: Identifiable{
    var id = UUID()
    let bitting: String
    let keyWay: String
    let unitNum : String
    let mPins: String
}

class LocksViewModel: ObservableObject{
    @Published var locks: [Lock] = []
    @Published var addLockOn: Bool = false
}

struct AddLockView: View{
    
    @ObservedObject var viewModel = LocksViewModel()
    @ObservedObject var details = JobDetails()
   
    @State var jobInput: Bool = false
    
    @State var textBitting = ""
    @State var textComment = ""
    @State var textCost = ""
    @State var textAddress = ""
    @State var textKeyway = ""
    @State var textMasterPins = ""
    @State var textUnit = ""
    @State var numKeys = 0
    
    
    var body: some View {
            
        VStack(alignment: .center){
            Spacer()
            
            Text("Information")
                .bold()
            
            Spacer()
  
            HStack{
                TextField("Cost", text: $textCost)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                    .accessibilityIdentifier("Cost2")
                
                TextField("Address", text: $textAddress)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                    .accessibilityIdentifier("Address2")
                
            }.frame(width:350)
                .background(Image("Background")
                    .scaledToFill()
                    .opacity(0.3))
            
            Spacer()
            
            HStack{
                TextField("Master Pins", text: $textMasterPins)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                    .accessibilityIdentifier("MP")
                
                TextField("Comment", text: $textComment)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                    .accessibilityIdentifier("Comment")
                
            }.frame(width:350)
            
            
            VStack(alignment: .center){
                Section(header: Text("Add New Key").bold()){
                    TextField("Bitting ", text: $textBitting)
                        .padding()
                        .background(.black.opacity(0.1))
                        .frame(width:350)
                        .border(.blue.opacity(0.8))
                        .accessibilityIdentifier("Bitting")
                    
                    HStack{
                        TextField("Keyway ", text: $textKeyway)
                            .padding()
                            .background(.black.opacity(0.1))
                            .border(.blue.opacity(0.8))
                            .accessibilityIdentifier("Keyway")
                        
                        TextField("Unit ", text: $textUnit)
                            .padding()
                            .background(.black.opacity(0.1))
                            .border(.blue.opacity(0.8))
                            .accessibilityIdentifier("Unit")
                        
                    }.frame(width:350)
                            

                    HStack{
              
                        Button(action: {
                            self.addToList()
                        }, label: {
                            Text("Add")
                                .bold()
                                .frame(width: 175, height: 40, alignment: .center)
                                .background(.blue)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("Add")
                        })
                        

                        Button(action: {
                            self.new()
                        }, label: {
                            Text("New")
                                .bold()
                                .frame(width: 175, height: 40, alignment: .center)
                                .background(.blue)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                                .accessibilityIdentifier("New")
                        })
                    }
                        
                }
                List{
                    ForEach(viewModel.locks){ lock in
                        LockRow(
                            unitNum: lock.unitNum,
                            keyWay: lock.keyWay,
                            bitting: lock.bitting,
                            mPins: lock.mPins
                        )
                    }
                }
            }
        }
    }
    
    func addToList(){
        viewModel.addLockOn = true
        guard !textBitting.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textUnit.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textKeyway.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        if(!jobInput){
            details.jobCost = textCost
            details.jobAddress = textAddress
            details.jobNotes = textComment
            
            jobInput = true
        }
        print(details.jobCost)
        print(details.jobAddress)
        
        let newLock = Lock(bitting: textBitting, keyWay: textKeyway, unitNum: textUnit, mPins: textMasterPins)
        viewModel.locks.append(newLock)
        numKeys=numKeys+1
        let num = "\(numKeys)"
        details.numkeys = num
        
        textUnit=""
        textBitting=""
        textKeyway=""
        textMasterPins=""
    }

    
    func new(){
        print("clearing")
        //clear values
        numKeys = 0
        details.numkeys = ""
        textCost = ""
        details.jobCost = ""
        textAddress = ""
        details.jobAddress = ""
        textMasterPins = ""
        
        textComment = ""
        details.jobNotes = ""
        viewModel.locks.removeAll()
        for lock in viewModel.locks{
            print(lock.keyWay)
            print(lock.bitting)
            print(lock.unitNum)
            print(lock.mPins)
        }
        
        textKeyway = ""
        textBitting = ""
        textUnit = ""
        print("CLEARED")
    }
}

struct LockRow: View{
    let unitNum: String
    let keyWay: String
    let bitting: String
    let mPins: String
    
    var body: some View{
        HStack{
            Text(bitting).accessibilityIdentifier("bitting")
            Text(keyWay).accessibilityIdentifier("keyWay")
            Text(unitNum).accessibilityIdentifier("unitNum")
            Text(mPins).accessibilityIdentifier("mPins")
        }
    }
}

struct AddLockView_Previews: PreviewProvider {
    static var previews: some View {
        AddLockView()
    }
}
