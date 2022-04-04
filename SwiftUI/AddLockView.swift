//
//  AddLockView.swift
//  LockThatDown
//
//  Created by Milford Gover on 2/13/22.
//

import SwiftUI

struct Lock: Identifiable{
    var id = UUID()
    //let jobTitle: String
    //let jobDate: String
    let bitting: String
    //let comment: String
    let keyWay: String
    let unitNum : String
    //let address: String
    //let cost: String
}

class LocksViewModel: ObservableObject{
    @Published var locks: [Lock] = [Lock( bitting: "", keyWay: "", unitNum: "")]
}

struct AddLockView: View{
    @StateObject var viewModel = LocksViewModel()
    
    @State var textName = ""
    @State var textDate = ""
    @State var textBitting = ""
    @State var textComment = ""
    @State var textCost = ""
    @State var textAddress = ""
    @State var textKeyway = ""
    @State var textMasterKey = ""
    @State var textUnit = ""
    @State var numKeys = 0
    
    
    var body: some View {
        
        VStack(alignment: .center){
            Spacer()
            
            Text("Information")
                .bold()
            
            Spacer()
            
            HStack{
                TextField("Name", text: $textName)
                    .padding()
                    .border(.blue.opacity(0.8))
                    .background(.black.opacity(0.1))
                
                TextField("Date", text: $textDate)
                    .padding()
                    .border(.blue.opacity(0.8))
                    .background(.black.opacity(0.1))
                
            }.frame(width:350)
            
            Spacer()
            
            HStack{
                TextField("Cost", text: $textCost)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                
                TextField("Address", text: $textAddress)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
            }.frame(width:350)
            
            Spacer()
            
            HStack{
                TextField("Master Pins", text: $textMasterKey)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                
                TextField("Comment", text: $textComment)
                    .padding()
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
            }.frame(width:350)
            
            
            VStack(alignment: .center){
                Section(header: Text("Add New Key").bold()){
                    TextField("Bitting ", text: $textBitting)
                        .padding()
                        .background(.black.opacity(0.1))
                        .frame(width:350)
                        .border(.blue.opacity(0.8))
                    
                    HStack{
                        TextField("Keyway ", text: $textKeyway)
                            .padding()
                            .background(.black.opacity(0.1))
                            .border(.blue.opacity(0.8))
                            
                        
                        TextField("Unit ", text: $textUnit)
                            .padding()
                            .background(.black.opacity(0.1))
                            .border(.blue.opacity(0.8))
                    }.frame(width:350)
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            self.addToList()
                        }, label: {
                            Text("Add")
                                .bold()
                                .frame(width: 150, height: 50, alignment: .center)
                                .background(.blue)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                        Button(action: {
                            self.export()
                            //Add Code here to export variables to database
                        }, label: {
                            Text("Export")
                                .bold()
                                .frame(width: 150, height: 50, alignment: .center)
                                .background(.blue)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                }
                List{
                    ForEach(viewModel.locks){ lock in
                        LockRow(
                            unitNum: lock.bitting,
                            keyWay: lock.unitNum,
                            bitting: lock.keyWay)
                    }
                }
            }
        }.offset(x:0, y:65)
         .background(Image("Background")
            .resizable()
            .scaledToFill()
            .clipped()
            .opacity(0.25))
            .edgesIgnoringSafeArea([.top])
    }
    
    func addToList(){
        guard !textBitting.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textUnit.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textKeyway.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let newLock = Lock(bitting: textBitting, keyWay: textKeyway, unitNum: textUnit)
        viewModel.locks.append(newLock)
        numKeys=numKeys+1
        textUnit=""
        textBitting=""
        textKeyway=""
    }
    
    func export(){
        guard numKeys>0 else {
            return
        }
        
        /*
         *Here's a for loop that loops through every lock added.
         *I show how you can access each lock's members in the print statements
         *I also show that these lock members should be tied to job details
         *provided, if any were provided.
         */
        for lock in viewModel.locks{
            print(lock.keyWay)
            print(lock.bitting)
            print(lock.unitNum)
            print(textName)
        }
        
        //clear values after every export
        numKeys = 0
        textName=""
        textDate=""
        textCost=""
        textAddress=""
        textMasterKey=""
        textComment=""
        viewModel.locks.removeAll()
    }
}

struct LockRow: View{
    let unitNum: String
    let keyWay: String
    let bitting: String
    
    var body: some View{
        HStack{
            Text(bitting)
            Text(keyWay)
            Text(unitNum)
        }
    }
}


struct AddLockView_Previews: PreviewProvider {
    static var previews: some View {
        AddLockView()
    }
}


