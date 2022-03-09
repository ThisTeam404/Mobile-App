//
//  AddLockView.swift
//  LockThatDown
//
//  Created by Milford Gover on 2/13/22.
//

import SwiftUI

struct Lock: Identifiable{
    var id = UUID()
    let jobTitle: String
    let jobDate: String
    let bitting: String
    let comment: String
    //let address: String
    //let cost: String
    //let keyWay:String
}
class LocksViewModel: ObservableObject{
    @Published var locks: [Lock] = [
        Lock(jobTitle: "Job Name", jobDate: "Job Date", bitting: "Key Bitting", comment: "Comments"
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
    //@State var textCost = ""
    //@State var textAddress = ""
    //@State var textKeyway = ""
    
    var body: some View {
        VStack{
            Text("LockThatDown").bold().foregroundColor(Color.cyan)
            HStack{
                Spacer()
                Button(action: {}) {
                    Text("Add Key").underline().foregroundColor(Color.gray)
                }
                Spacer()
                Button(action:{}) {
                    Text("Create Job").foregroundColor(Color.gray)
                }
                Spacer()
            }
            NavigationView{
                VStack(alignment: .center){
                    Section(header: Text("Add New Key").bold()){
                        TextField("Name ", text: $textName)
                            .padding()
                        TextField("Date ", text: $textDate)
                            .padding()
                        TextField("Bitting ", text: $textBitting)
                            .padding()
                        TextField("Comment ", text: $textComment)
                            .padding()
                        Button(action: {
                            self.addToList()
                        }, label: {
                            Text("Add")
                                .bold()
                                .frame(width: 250, height: 50, alignment: .center)
                                .background(Color.cyan)
                                .cornerRadius(8)
                                .foregroundColor(Color.black)
                        })
                    }
                    List{
                        ForEach(viewModel.locks){ lock in
                            LockRow(jobTitle: lock.jobTitle,
                                    jobDate: lock.jobDate,
                                    comment: lock.comment,
                                    bitting: lock.bitting)
                        }
                    }
                }.navigationBarTitle("")
                 .navigationBarHidden(true)
            }
        }
    }
    func addToList(){
        guard !textName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textBitting.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textDate.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard !textComment.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let newLock = Lock(jobTitle: textName, jobDate: textDate, bitting: textBitting, comment: textComment)
        viewModel.locks.append(newLock)
        
        textDate=""
        textBitting=""
        textComment=""
        textName=""
    }
}

struct LockRow: View{
    let jobTitle: String
    let jobDate: String
    let comment: String
    let bitting: String
    
    var body: some View{
        HStack{
            Text(jobTitle)
            Text(jobDate)
            Text(comment)
            Text(bitting)
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
