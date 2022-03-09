//
//  createJob.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 3/9/22.
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
    //@Binding var changeView:Bool
    
    @State var flag = false
    @State var numberOfLocksCombos: String = ""
    @State var isOn = false
    @State var confirmFlag: Bool = false
    @State var cancelFlag: Bool = false
    
    @ObservedObject var viewModel = numComboViewModel()
    
    var body: some View {
      
        //NavigationView{
        
            ZStack{
        
                VStack{
                
                    
                    HStack{
                        //Meant to go to add lock page or create a new job
                        Spacer()
                        
                        Button("Add Lock",action: {})
                  
                        
                        Spacer()
                        
                        Button("Create Job", action: {})
             
                        
                        Spacer()
                        
                    }
                    
                    HStack{
                        
                        Spacer()
                       
                        Text("Keyway Type")
                            .padding()
                        
                        Spacer()
                        
                        //change color if chosen
                        Button("Schlage", action:{ print("Schlage")})
                            .padding()
                            .frame(height: 25)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    
                        Spacer()
                        
                        Button("Kwikset", action:{ print("Kwikset")})
                            .padding()
                            .frame(height: 25)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
   
                        
                        Spacer()
                    
                    }

                    VStack{
                        
                        Text("Number of Locks:")
                            .padding()

                        TextField("Number of Locks ", text: $numberOfLocksCombos)
                            .padding()
                            .frame(width: 300)
                            .border(.blue)
                     
                        HStack{
                            
                            Spacer()
            
                            Button(action: { self.addToList() }, label: {Text("Confirm")})
              
                            
                            Spacer()
                           
                            Button(action: {viewModel.numCombos.removeAll(); numberOfLocksCombos = ""}, label: {Text("Cancel")})
                  
             
                            Spacer()
                        }
                            .padding()
                            .frame(width: 300, height: 35)
                            .foregroundColor(.white)
                            .background(.blue)
                
                        
                    
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
                        })
                            .alert(isPresented: $confirmFlag) {Alert(title: Text("Confirmation"), message: Text("Do you want to save the job information to the Add Lock page?"), primaryButton: .default(Text("Yes"), action: {print("Confirm test")}), secondaryButton: .cancel(Text("No")))}
              
                        Spacer()
                        
                        Button("Cancel", action: {
                            cancelFlag = true
                        })
                            .alert(isPresented: $cancelFlag) {Alert(title: Text("Cancel?"), message: Text("Do you want to delete your job information?"), primaryButton: .default(Text("Yes"), action: {print("Cancel test")}), secondaryButton: .cancel(Text("No")))}
    
                        Spacer()
                    } .padding()
                        .frame(width: 300, height: 25)
                        .foregroundColor(.white)
                        .background(.blue)
                        
                    
                }
                
            }//.offset(x: 0, y: -40.0)
            
        //}.navigationTitle(Text("Create Job"))
          //  .navigationBarTitle("Create Job")
            //    .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func addToList() {
        
        guard Int(numberOfLocksCombos) != nil else { return }
        
        guard Int(numberOfLocksCombos)! > 0 else { return }
        
        for _ in 1 ... Int(numberOfLocksCombos)!
        {
            let num = randomNumber()
            let newCombo = numCombo(numberCombo: String(num))
            viewModel.numCombos.append(newCombo)
        }
        
    }
    
    func randomNumber() -> Int {
        return Int.random(in: 10000..<99999)
    }
    
}

struct CreateJobView_Previews: PreviewProvider {
    static var previews: some View {
       createJob()
    }
}
