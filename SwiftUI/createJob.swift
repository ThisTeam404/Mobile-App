//
//  createJob.swift
//  LockThatDown
//
//  Created by Herrera, Anthony on 2/9/22.
//

import SwiftUI

struct numCombo: Identifiable{
    var id = UUID()
    @State var numberCombo: String = ""
}
class numComboViewModel: ObservableObject{
    @Published var numCombos: [numCombo] = []
}
struct createJob: View {
    @Binding var changeView:Bool
    
    @State var flag = false
    @State var numberOfLocksCombos: String = ""
    @State var isOn = false
    @State var confirmFlag: Bool = false
    @State var cancelFlag: Bool = false
    
    @ObservedObject var viewModel = numComboViewModel()
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
                    Button("Create Job", action:{ })
                    Spacer()
                }
                HStack{
                    Text("Keyway Type").padding()
                    Spacer()
                    Button("Schlage", action:{ print("Schlage")})
                    Spacer()
                    Button("Kwikset", action:{ print("Kwikset")})
                    Spacer()
                }
                Text("Number of Locks:")
                VStack{
                        TextField("Name ", text: $numberOfLocksCombos)
                                .padding()
                    HStack{
                        Spacer()
                        Button(action: { self.addToList() }, label: {Text("Confirm")})
                        Spacer()
                        Button(action: {viewModel.numCombos.removeAll(); numberOfLocksCombos = ""}, label: {Text("Cancel")})
                        Spacer()
                    }
                    List{
                        ForEach(viewModel.numCombos){ x in
                            Text(x.numberCombo)
                        }
                    }
                }
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
    func addToList(){
        guard Int(numberOfLocksCombos) != nil else {
            return
        }
        guard Int(numberOfLocksCombos)! > 0 else {
            return
        }
        for _ in 1 ... Int(numberOfLocksCombos)!
        {
            var num = randomNumber()
            let newCombo = numCombo(numberCombo: String(num))
            viewModel.numCombos.append(newCombo)
        }
    }
    func randomNumber() -> Int
    {
        return Int.random(in: 10000..<99999)
    }
    
}

    
/*struct createJob_Previews: PreviewProvider {
    static var previews: some View {
        createJob()
    }
}*/

