//
//  createJob.swift
//  GoogleLoginOption
//
//  Created by Kaily Estepa, Anthony Herrera, and Saba Taghibeik on 4/3/22.
//

import SwiftUI


struct numCombo: Identifiable{
    var id = UUID()
    @State var numKeys: String
    var combination: [String]
    var combinationPins: [String]
    var keyWayType = ""
    var hasMk: Bool = false
    var masterKey: String
    var masterPins: [String]
}

class numComboViewModel: ObservableObject{

    @Published var numCombos: [numCombo] = [numCombo(numKeys: "0", combination: [""], combinationPins: [""], keyWayType: "", hasMk: false, masterKey: "", masterPins: [""])]

}

struct createJob: View {
    
    @State var kwiksetFlag = false
    @State var schlageFlag = false
    @State var keyWayFlag = true
    
    
    @State var flag = false
    @State var numberOfLocksCombos: Int = 1
    @State var isOn = false                             //the isOn value will take care of the hasMKValue
    @State var confirmFlag: Bool = false
    @State var confirmFlag2: Bool = false
    @State var cancelFlag: Bool = false
    
    @ObservedObject var viewModel = numComboViewModel()
    
    @State var numChangeKeysText = ""
    @State var masterKeyLevelValue = "0"
    @State var keywayVariable = ""
 
    @State var bottomPinsText = ""
    @State var masterPinsText = ""
    @State var combinationText = ""
    
    
    @State var someKeyGenerator1 = keyGenerator(keyway: "", numChangeKeys: 0, masterKeyLevel: 0)
    
    @State var changeKey1 = [""]
    @State var changePins1 = [""]
    @State var masterKey1 = ""
    @State var masterPins1 = [""]
    
    
    var body: some View {
      
        //NavigationView{
        
            ZStack{
        
                VStack{
                    //.navigationBarTitle(Text("LockThatDown"))
                    
                    Spacer()
                    //Text("Create Job")
                    
                    HStack{
                        
                        Spacer()
                       
                        Text("Keyway Type")
                            .padding()
                        
                        Spacer()
                        if(!schlageFlag)
                        {
                            Button("Schlage", action:{schlageFlag = true;
                                kwiksetFlag = false; keyWayFlag = false
                                keywayVariable = "SC1"
                            })
                                .padding()
                                .frame(height: 25)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(8)
                                .disabled(schlageFlag)
                        }
                        else
                        {
                            Button("Schlage", action:{})
                                .padding()
                                .frame(height: 25)
                                .foregroundColor(.blue)
                                .background(.white)
                                .cornerRadius(8)
                                .border(Color.blue, width: 2)
                            
                        }
                    
                        Spacer()
                        
                        if(!kwiksetFlag)
                        {
                            Button("Kwikset", action:{schlageFlag = false;
                                kwiksetFlag = true;keyWayFlag = false
                                keywayVariable = "KW1"
                            }).disabled(kwiksetFlag)
                                .padding()
                                .frame(height: 25)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(8)
                                .disabled(kwiksetFlag)
                        }
                        else
                        {
                            Button("Kwikset", action:{})
                                .padding()
                                .frame(height: 25)
                                .foregroundColor(.blue)
                                .background(.white)
                                .cornerRadius(8)
                                .border(Color.blue, width: 2)
                            
                        }
   
                        
                        Spacer()
                    
                    }.offset(y:60)

                    VStack{
                        TextField("Number of Change Keys", text: $numChangeKeysText)
                            .padding()
                            .frame(width: 300)
                            .border(.blue)
                            .background(.black.opacity(0.1))
                        HStack{
                        Menu{
                            Button("0", action: {masterKeyLevelValue = "0"
                                isOn = false
                            })
                            Button("1", action: {masterKeyLevelValue = "1"
                                isOn = true
                            })
                        } label: {
                            Label("Master Key Levels", systemImage: "chevron.down")}
                        
                        Text(masterKeyLevelValue)
                        }
                        
                        if(kwiksetFlag || schlageFlag)
                        {
                        Button("Generate", action:{
                            confirmFlag2 = true
                            guard Int(numChangeKeysText) != nil else {
                                confirmFlag2 = false
                                return}

                            guard Int(numChangeKeysText)! > 0  else {
                                confirmFlag2 = false
                                return}
                            
                            
                            
                            someKeyGenerator1 = keyGenerator(keyway: keywayVariable, numChangeKeys: Int(numChangeKeysText) ?? 1, masterKeyLevel: Int(masterKeyLevelValue) ?? 0)
                            
                            if(isOn)
                            {
                                someKeyGenerator1.generateMasterKey() //step 1
                                masterKey1 = someKeyGenerator1.getMasterKey()
                                
                                someKeyGenerator1.generateChangeKeys() //step 2
                                changeKey1 = someKeyGenerator1.getChangeKeys()

                                someKeyGenerator1.generateChangePins() //step 3
                                changePins1 = someKeyGenerator1.getChangePins()
                                
                                someKeyGenerator1.generateMasterPins() //step 4
                                masterPins1 = someKeyGenerator1.getMasterPins()
                            }
                            else
                            {
                                someKeyGenerator1.generateChangeKeys()
                                changeKey1 = someKeyGenerator1.getChangeKeys()

                                someKeyGenerator1.generateChangePins()
                                changePins1 = someKeyGenerator1.getChangePins()
                            }
                        })
                            .frame(width: 250, height: 35, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .foregroundColor(Color.white)
                            .disabled(keyWayFlag)
                        }
                        else{
                            Button("Generate", action:{})
                                .frame(width: 250, height: 35, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(8)
                                .foregroundColor(Color.blue)
                                .disabled(keyWayFlag)
                                .border(Color.blue, width: 2)
                        }
                        
                     
                        HStack{
                            
                            Spacer()
            
                            if(confirmFlag2)
                            {
                            Button(action: {
                                if(!flag)
                                {
                                    flag = true
                                    viewModel.numCombos.removeAll()
                                }
                                
                                
                                if(kwiksetFlag == false && schlageFlag == false)
                                {
                                    keyWayFlag = true
                                }
                                else
                                {
                                    self.addToList()
                                    confirmFlag2 = false
                                }}, label: {Text("Confirm")})
                                .padding()
                                .frame(width: 175, height: 35)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(8)
                            }
                            else
                            {
                                Button("Confirm", action:{})
                                    .frame(width: 175, height: 35, alignment: .center)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .disabled(confirmFlag2)
                                    .border(Color.blue, width: 2)
                                    .cornerRadius(8)
                            }
              
                            
                            Spacer()
                           
                            Button(action: {
                                keyWayFlag = false
                                confirmFlag2 = false
                                schlageFlag = false
                                kwiksetFlag = false
                                keywayVariable = ""
                                numberOfLocksCombos = 1
                                numChangeKeysText = ""
                                masterKeyLevelValue = "0"
                            }, label: {Text("Reset")})
                                .padding()
                                .frame(width: 175, height: 35)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(8)
                  
             
                            Spacer()
                        }
                        
                        
                    }.offset(y:50)
                    Spacer()
                    HStack{
                        Text("# Key")
                        Text("Key combo #")
                        Text("Key Pins #")
                        Text("Key Type")
                        Text("Is MK")
                        Text("Master combo #")
                        Text("M Pins")
                    }.offset(y:45)
                    List{
                        
                        if(flag)
                        {
                        ForEach(viewModel.numCombos){ num in
                            
                            numComboRow(numKeys: num.numKeys,
                                        combo: String(num.combination.joined(separator: ", ")),
                                        comboPins: String(num.combinationPins.joined(separator: ", ")),
                                        keyWay: num.keyWayType,
                                        hasMKValue: String(num.hasMk),
                                        masterKey: String(num.masterKey),
                                        masterPins: String(num.masterPins.joined(separator: ", ")))
                        }
                        }
                        
                    }.offset(y:35)
                    HStack{
                        
                        Spacer()
                        
                        Button("Confirm",action: {
                            confirmFlag = true
                        }).padding()
                            .frame(width: 175, height: 35)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                            .alert(isPresented: $confirmFlag) {Alert(title: Text("Confirmation"), message: Text("Do you want to save the job information to the Add Lock page?"), primaryButton: .default(Text("Yes"), action: {print("Confirm test")}), secondaryButton: .cancel(Text("No")))}
              
                        Spacer()
                        
                        Button("Cancel", action: {
                            cancelFlag = true
                        })
                            .alert(isPresented: $cancelFlag) {Alert(title: Text("Cancel?"), message: Text("Do you want to delete the job information?"), primaryButton: .default(Text("Yes"), action: {
                                keywayVariable = ""
                                kwiksetFlag = false
                                schlageFlag = false
                                confirmFlag2 = false
                                keyWayFlag = true
                                viewModel.numCombos.removeAll()
                                numberOfLocksCombos = 1
                                numChangeKeysText = ""
                                masterKeyLevelValue = "0"
                            }), secondaryButton: .cancel(Text("No")))}
                            .padding()
                            .frame(width: 175, height: 35)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
    
                        Spacer()
                    }.frame(height:110)
                        
                    Spacer()
                }
                
            }.background(Image("Background")
                .resizable()
                .scaledToFill()
                .clipped()
                .opacity(0.25))
            .edgesIgnoringSafeArea([.top,.bottom])
        
    }
    
    func addToList() {
        if(!isOn)
        {
            masterKey1 = "N/A"
            masterPins1 = ["N/A"]
            changePins1 = [""]
        }
        let newCombo = numCombo(numKeys: String(numberOfLocksCombos), combination: changeKey1, combinationPins: changePins1, keyWayType: keywayVariable, hasMk: isOn, masterKey: masterKey1, masterPins: masterPins1)
            viewModel.numCombos.append(newCombo)
        numberOfLocksCombos = numberOfLocksCombos + 1
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
        if((masterKey.count == combinationLength) && (checkMACSValue(key: masterKey))) {
            var currCut:Int, currIndex:String.Index, prevCut:Int, prevIndex:String.Index
            for i in 0..<combinationLength {
                //check to make sure there's an odd even / even odd pattern
                if (i > 0) {
                    prevIndex = masterKey.index(masterKey.startIndex, offsetBy: (i-1))
                    prevCut = Int(masterKey[prevIndex...prevIndex]) ?? 0
                    
                    currIndex = masterKey.index(masterKey.startIndex, offsetBy: i)
                    currCut = Int(masterKey[currIndex...currIndex]) ?? 0
                    
                    if ((currCut % 2) == (prevCut % 2)) {
                        print("master key isn't odd even pattern.")
                        return
                    }
                }
            }
            self.masterKey = masterKey
        }
        else {
            print("master key is not correct length or doesn't satisfy macs value.")
        }
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
        var currKey:String
        
        for firstVaryChamber in 0..<combinationLength {
            for possibleDepth in getMinDepth()...getMaxDepth() {
                currKey = ""
                mkIndex = masterKey.index(masterKey.startIndex, offsetBy: (firstVaryChamber))
                mkCut = Int(masterKey[mkIndex...mkIndex]) ?? 0
                if(possibleDepth != mkCut) {
                    if((mkCut % 2) == (possibleDepth % 2)) {
                        variedChambers.append(firstVaryChamber)
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
                                                       if(variedChambers[indexOfVary] != firstVaryChamber) {
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
                                                                           if((variedChambers[indexOfVary] != firstVaryChamber) && (variedChambers[indexOfVary] != secondVaryChamber)) {
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
        var viableKey:Bool
        //if system has MK, generate viable keys then pick random ones for bitting
        if(masterKey.isEmpty == false) {
            var allViableKeys = [String]()
            for numVaries in (1...3) {
                let tempViableKeys = viableKeys(numVaries: numVaries)
                if(numChangeKeys <= tempViableKeys.count) {
                    allViableKeys = tempViableKeys
                    break
                }
                else if(numVaries == 3) {
                    print("Not possible to generate this many keys with this master key.")
                    return
                }
            }
            
            for i in 0..<numChangeKeys {
                randomCK = Int.random(in: 0..<(allViableKeys.count))
                changeKeys[i] = String(allViableKeys[randomCK])
                allViableKeys.remove(at: randomCK)
            }
        }
        //if system has no MK, generate random bittings
        else {
            for i in 0..<numChangeKeys {
                viableKey = false
                 while(viableKey == false) {
                     changeKey = ""
                     for chamber in 0..<combinationLength {
                        var randomCut = Int.random(in: getMinDepth()...getMaxDepth())
                        //check to make sure there's an odd even / even odd pattern
                        if (chamber > 0) {
                            let prevIndex = changeKey.index(changeKey.startIndex, offsetBy: (chamber-1))
                            let prevCut = Int(changeKey[prevIndex...prevIndex]) ?? 0
                            while ((randomCut % 2) == (prevCut % 2)) {
                                randomCut = Int.random(in: getMinDepth()...getMaxDepth())
                            }
                        }
                        changeKey += String(randomCut)
                    }
                    if(checkMACSValue(key: changeKey) && !isRepeatKeyBitting(viableKeysGenerated: changeKeys, currentKey: changeKey)){
                        viableKey = true
                        changeKeys[i] = changeKey
                    }
                }
            }
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
                changePins[i] = changeKeys[i]
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

struct numComboRow: View{
    let numKeys: String
    let combo: String
    let comboPins: String
    let keyWay: String
    let hasMKValue: String
    let masterKey: String
    let masterPins: String
    
    var body: some View{
        HStack{
            Text(numKeys)
            Text(combo)
            Text(comboPins)
            Text(keyWay)
            Text(hasMKValue)
            Text(masterKey)
            Text(masterPins)
        }
    }
    
}
struct CreateJobView_Previews: PreviewProvider {
    static var previews: some View {
        createJob()
    }
}
