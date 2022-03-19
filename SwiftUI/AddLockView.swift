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
    @Published var locks: [Lock] = [
        Lock( bitting: "", keyWay: "", unitNum: ""
             //, address: "Address", cost: "Cost", keyWay: "Keyway Type"
            )
            ]
}

struct AddLockView: View{
    @StateObject var viewModel = LocksViewModel()
    //@Binding var changeView:Bool
    
    @State var textName = ""
    @State var textDate = ""
    @State var textBitting = ""
    @State var textComment = ""
    @State var textCost = ""
    @State var textAddress = ""
    @State var textKeyway = ""
    @State var textMasterKey = ""
    @State var textUnit = ""
    //@State var testkeyWay = ""
    @State var numKeys = 0
    
    
    var body: some View {
        VStack(alignment: .center){
            Text("LockThatDown").bold().foregroundColor(Color.cyan)
            
            Spacer()
            HStack{
                TextField("Name", text: $textName)
                    .padding()
                TextField("Date", text: $textDate)
                    .padding()
            }
            Spacer()
            HStack{
                TextField("Cost", text: $textCost)
                    .padding()
                TextField("Address", text: $textAddress)
                    .padding()
            }
            Spacer()
            HStack{
                TextField("Master Pins", text: $textMasterKey)
                    .padding()
                TextField("Comment", text: $textComment)
                    .padding()
            }
            
            NavigationView{
                VStack(alignment: .center){
                    Section(header: Text("Add New Key").bold()){
                        TextField("Bitting ", text: $textBitting)
                            .padding()
                        HStack{
                            TextField("Keyway ", text: $textKeyway)
                                .padding()
                            TextField("Unit ", text: $textUnit)
                                .padding()
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                                self.addToList()
                            }, label: {
                                Text("Add")
                                    .bold()
                                    .frame(width: 100, height: 50, alignment: .center)
                                    .background(Color.cyan)
                                    .cornerRadius(8)
                                    .foregroundColor(Color.black)
                            })
                            
                            Spacer()
                            Button(action: {
                                self.export()
                                //Add Code here to export variables to
                                //database
                            }, label: {
                                Text("Export")
                                    .bold()
                                    .frame(width: 100, height: 50, alignment: .center)
                                    .background(Color.cyan)
                                    .cornerRadius(8)
                                    .foregroundColor(Color.black)
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
                }.navigationBarTitle("")
                 .navigationBarHidden(true)
            }
        }
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

/*
struct AddLockView_Previews: PreviewProvider {
    static var previews: some View {
        AddLockView()
    }
}
 */
