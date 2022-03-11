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

class keyGenerator {
    private let KW1MACSValue:Int = 4
    private let SC1MACSValue:Int = 7
    private let KW1MinDepth:Int = 1
    private let KW1MaxDepth:Int = 7
    private let SC1MinDepth:Int = 0
    private let SC1MaxDepth:Int = 9
    private let combinationLength:Int = 5
    
    private var masterKey:String
    private var keyway:String
    private var numChangeKeys:Int
    private var changeKeys = [String]()
    private var changePins = [String]()
    private var masterPins = [String]()

    /*constructor: generate change keys w/ a master key*/
    init(keyway:String, numChangeKeys:Int, masterKeyLevel:Int) {
        masterKey = ""
        self.numChangeKeys = numChangeKeys
        self.keyway = keyway
        changeKeys = [String](repeating: "", count: numChangeKeys)
        changePins = [String](repeating: "", count: numChangeKeys)
        masterPins = [String](repeating: "", count: numChangeKeys)
    }

    func setMasterKey(masterKey:String) {
        self.masterKey = masterKey
    }
    
    func setNumChangeKeys(numChangeKeys:Int) {
        self.numChangeKeys = numChangeKeys
    }
    
    func getMasterKey() -> String {
        return masterKey
    }
    
    func getChangeKeys() -> [String] {
        return changeKeys
    }
    
    func getChangePins() -> [String] {
        return changePins
    }
    
    func getMasterPins() -> [String] {
        return masterPins
    }
    
    /*getter for minDepth*/
    func getMinDepth() -> Int {
        var minDepth:Int = 0
        if(keyway == "KW1") {
            minDepth = KW1MinDepth
        }
        else if(keyway == "SC1") {
            minDepth = SC1MinDepth
        }
        return minDepth
    }
    
    /*getter for maxDepth*/
    func getMaxDepth() -> Int {
        var maxDepth:Int = 0
        if(keyway == "KW1") {
            maxDepth = KW1MaxDepth
        }
        else if(keyway == "SC1") {
            maxDepth = SC1MaxDepth
        }
        return maxDepth
    }
    
    /*getter for MACS value*/
    func getMACSValue() -> Int {
        var macsValue:Int = 0
        if(keyway == "KW1") {
            macsValue = KW1MACSValue
        }
        else if(keyway == "SC1") {
            macsValue = SC1MACSValue
        }
        return macsValue
    }
    
    /*checks if adjacent cut values surpass MACS value. If they do, then key cut isn't viable*/
    func checkMACSValue(key:String) -> Bool {
        var isKeyCutAllowed = true
        var keyIndex1:String.Index, keyIndex2:String.Index
        var keyCut1:Int, keyCut2:Int
        for index in 0..<(combinationLength - 1) {
            keyIndex1 = key.index(key.startIndex, offsetBy: (index))
            keyCut1 = Int(key[keyIndex1...keyIndex1]) ?? 0
            keyIndex2 = key.index(key.startIndex, offsetBy: (index+1))
            keyCut2 = Int(key[keyIndex2...keyIndex2]) ?? 0
            if(abs(keyCut1 - keyCut2) > getMACSValue()) {
                isKeyCutAllowed = false
                return isKeyCutAllowed
            }
        }
        return isKeyCutAllowed
    }
    
    /*method checks if master key bitting has lowest depth value*/
    private func hasLowestDepth(masterKey:String) -> Bool {
        for index in 0..<combinationLength {
            let mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (index))
            let mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
            if(mkCut == getMinDepth()) {
                return true
            }
        }
        return false
    }
    
    /*method checks if a change key bitting already current key bitting generated is a */
    private func isRepeatKeyBitting(viableKeysGenerated: [String], currentKey:String) -> Bool {
        for i in 0..<viableKeysGenerated.count {
            if(currentKey.elementsEqual(viableKeysGenerated[i])) {
                return true
            }
        }
        return false
    }
    
    /*method that generates and returns of all viable CK bitting that can be generated from the MK*/
    private func viableKeys(numVaries:Int) -> [String] {
        var viableKeys = [String]()
        var variedChambers = [Int]() // int array to store the chamber(s) being varied for the CK
        var newValues = [Int]() // int array to store the values that will be varied for the CK
        var mkIndex:String.Index // variable for obtaining the index of the masterKey
        var mkCut:Int // variable for an individual cut of the master key bitting
        var currKey:String = ""
        
        for varyChamber in 0..<combinationLength {
            for possibleDepth in getMinDepth()...getMaxDepth() {
                currKey = ""
                mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (varyChamber))
                mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                if(possibleDepth != mkCut) {
                    if((mkCut % 2) == (possibleDepth % 2)) {
                        variedChambers.append(varyChamber)
                        newValues.append(possibleDepth)
                        
                        if(numVaries == 1) {
                            for currKeyChamber in 0..<combinationLength {
                                if(variedChambers.contains(currKeyChamber)) {
                                    let indexOfVary = variedChambers.firstIndex(of: currKeyChamber) ?? 0
                                    currKey += String(newValues[indexOfVary])
                                    variedChambers.remove(at: indexOfVary)
                                    newValues.remove(at: indexOfVary)
                                }
                                else {
                                    mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (currKeyChamber))
                                    mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                                    currKey += String(mkCut)
                                }
                            }
                            if(checkMACSValue(key: currKey)) {
                                if(!isRepeatKeyBitting(viableKeysGenerated: viableKeys, currentKey: currKey)) {
                                    viableKeys.append(currKey)
                                    //print("key was appended as viable: " + currKey)
                                }
                            }
                        }
                        else if(numVaries == 2) {
                            for secondVaryChamber in 0..<combinationLength {
                                if(!variedChambers.contains(secondVaryChamber)) {
                                    for secondPossibleDepth in getMinDepth()...getMaxDepth() {
                                        currKey = ""
                                        mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (secondVaryChamber))
                                        mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                                        if(secondPossibleDepth != mkCut) {
                                           if((mkCut % 2) == (secondPossibleDepth % 2)) {
                                               variedChambers.append(secondVaryChamber)
                                               newValues.append(secondPossibleDepth)
                                               
                                               //generate the key
                                               for currKeyChamber in 0..<combinationLength {
                                                   if(variedChambers.contains(currKeyChamber)) {
                                                       let indexOfVary = variedChambers.firstIndex(of: currKeyChamber) ?? 0
                                                       currKey += String(newValues[indexOfVary])
                                                       if(indexOfVary != varyChamber) {
                                                           variedChambers.remove(at: indexOfVary)
                                                           newValues.remove(at: indexOfVary)
                                                       }
                                                   }
                                                   else {
                                                       mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (currKeyChamber))
                                                       mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                                                       currKey += String(mkCut)
                                                   }
                                               }
                                               
                                               if(checkMACSValue(key: currKey)) {
                                                   if(!isRepeatKeyBitting(viableKeysGenerated: viableKeys, currentKey: currKey)) {
                                                       viableKeys.append(currKey)
                                                       //print("key was appended as viable: " + currKey)
                                                   }
                                               }
                                           }
                                        }
                                    }
                                }
                            }
                        }
                        else if(numVaries == 3) {
                            for secondVaryChamber in 0..<combinationLength {
                                if(!variedChambers.contains(secondVaryChamber)) {
                                    for secondPossibleDepth in getMinDepth()...getMaxDepth() {
                                        currKey = ""
                                        mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (secondVaryChamber))
                                        mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                                        if(secondPossibleDepth != mkCut) {
                                           if((mkCut % 2) == (secondPossibleDepth % 2)) {
                                               variedChambers.append(secondVaryChamber)
                                               newValues.append(secondPossibleDepth)
                                               
                                               for thirdVaryChamber in 0..<combinationLength {
                                                   if(!variedChambers.contains(thirdVaryChamber)) {
                                                       for thirdPossibleDepth in getMinDepth()...getMaxDepth() {
                                                           currKey = ""
                                                           mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (thirdVaryChamber))
                                                           mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                                                           if(thirdPossibleDepth != mkCut) {
                                                               if((mkCut % 2) == (thirdPossibleDepth % 2)) {
                                                                   variedChambers.append(thirdVaryChamber)
                                                                   newValues.append(thirdPossibleDepth)
                                                                   
                                                                   //generate the key
                                                                   for currKeyChamber in 0..<combinationLength {
                                                                       if(variedChambers.contains(currKeyChamber)) {
                                                                           let indexOfVary = variedChambers.firstIndex(of: currKeyChamber) ?? 0
                                                                           currKey += String(newValues[indexOfVary])
                                                                           if((indexOfVary != varyChamber) || (indexOfVary != secondVaryChamber)) {
                                                                               variedChambers.remove(at: indexOfVary)
                                                                               newValues.remove(at: indexOfVary)
                                                                           }
                                                                       }
                                                                       else {
                                                                           mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (currKeyChamber))
                                                                           mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                                                                           currKey += String(mkCut)
                                                                       }
                                                                   }
                                                                   
                                                                   if(checkMACSValue(key: currKey)) {
                                                                       if(!isRepeatKeyBitting(viableKeysGenerated: viableKeys, currentKey: currKey)) {
                                                                           viableKeys.append(currKey)
                                                                           //print("key was appended as viable: " + currKey)
                                                                       }
                                                                   }
                                                               }
                                                           }
                                                       }
                                                   }
                                               }
                                           }
                                        }
                                    }
                                }
                            }
                        }
                        variedChambers.removeAll()
                        newValues.removeAll()
                    }
                }
            }
        }
        //print("number of viable keys generated: " + String(viableKeys.count))
        return viableKeys
    }
    
    /*generates a random master key bitting*/
    func generateMasterKey() {
        var viableMK:Bool = false
        var randomCut:Int = 0
        var prevIndex:String.Index
        var prevCut:Int = 0
        while (!viableMK) {
            masterKey = ""
            for i in 0..<combinationLength {
                randomCut = Int.random(in: getMinDepth()...getMaxDepth())
                //check to make sure there's an odd even / even odd pattern
                if (i > 0) {
                    prevIndex = masterKey.index(masterKey.startIndex, offsetBy: (i-1))
                    prevCut = Int(masterKey[prevIndex...prevIndex]) ?? 0
                    while ((randomCut % 2) == (prevCut % 2)) {
                        randomCut = Int.random(in: getMinDepth()...getMaxDepth())
                    }
                }
                masterKey += String(randomCut)
            }
            if(checkMACSValue(key: masterKey) && hasLowestDepth(masterKey: masterKey)) {
                viableMK = true
            }
        }
    }
    
    /*generate the number of change keys requested*/
    func generateChangeKeys() {
        var randomCK:Int = 0
        var changeKey:String
        //if system has MK, generate viable keys then pick random ones for bitting
        if(masterKey.isEmpty == false) {
            var allViableKeys = [String]()
            if(numChangeKeys <= viableKeys(numVaries: 1).count) {
                allViableKeys = viableKeys(numVaries: 1)
            }
            else if(numChangeKeys <= viableKeys(numVaries: 2).count) {
                allViableKeys = viableKeys(numVaries: 2)
            }
            
            else if(numChangeKeys <= viableKeys(numVaries: 3).count) {
                allViableKeys = viableKeys(numVaries: 3)
            }
            else {
                print("Not possible to generate this many keys with this master key.")
            }
            
            for i in 0..<numChangeKeys {
                randomCK = Int.random(in: 0..<(allViableKeys.count))
                changeKeys[i] = String(allViableKeys[randomCK])
                allViableKeys.remove(at: randomCK)
            }
        }
        //if system has no MK, generate random bittings
        else {
            /*generate change keys for a system with no MK*/
        }
    }
    
    /*generate bottom (change key) pins*/
    func generateChangePins() {
        var ckCutIndex:String.Index
        var mkCutIndex:String.Index
        var ckCut:Int
        var mkCut:Int
        var cutDifference:Int
        for i in 0..<numChangeKeys {
            if(masterKey.isEmpty == false) {
                for j in 0..<combinationLength {
                    ckCutIndex = (changeKeys[i]).index((changeKeys[i]).startIndex, offsetBy: j)
                    ckCut = Int((changeKeys[i])[ckCutIndex...ckCutIndex]) ?? 0
                    mkCutIndex = (masterKey).index(masterKey.startIndex, offsetBy: j)
                    mkCut = Int(masterKey[mkCutIndex...mkCutIndex]) ?? 0
                    
                    cutDifference = mkCut - ckCut
                    if(cutDifference > 0) {
                        changePins[i] += String(ckCut)
                    }
                    else {
                        changePins[i] += String(mkCut)
                    }
                }
            }
            else {
                /*change key pins for a no MK system*/
            }
        }
    }
    
    /*generate the master pins for each key that has a master key*/
    func generateMasterPins() {
        var ckCutIndex:String.Index
        var mkCutIndex:String.Index
        var ckCut:Int
        var mkCut:Int
        var pin:Int
        var masterPin:String
        
        for i in 0..<numChangeKeys {
            masterPin = ""
            for j in 0..<combinationLength {
                ckCutIndex = (changeKeys[i]).index(changeKeys[i].startIndex, offsetBy: j)
                ckCut = Int((changeKeys[i])[ckCutIndex...ckCutIndex]) ?? 0
                mkCutIndex = (masterKey).index(masterKey.startIndex, offsetBy: j)
                mkCut = Int(masterKey[mkCutIndex...mkCutIndex]) ?? 0
                
                pin = abs(mkCut - ckCut)
                masterPin += String(pin)
            }
            masterPins[i] = masterPin
        }
    }
}
struct CreateJobView_Previews: PreviewProvider {
    static var previews: some View {
       createJob()
    }
}
