//
//  createJob.swift
//  GoogleLoginOption
//
//  Created by Saba Taghibeik and Anthony Herrera on 4/3/22.
//

import SwiftUI


struct numCombo: Identifiable{
    var id = UUID()
    @State var numKeys: String
    var combination = [[String]]()
    var combinationPins = [[String]]()
    var keyWayType = ""
    var hasMk: Bool = false
    var masterKeyLevel: String
    var masterKey: [String]
    var masterPins1 = [[String]]()
    var masterPins2 = [[String]]()
    var subMasterKeys = [String]()
}

class numComboViewModel: ObservableObject{

    @Published var numCombos: [numCombo] = [numCombo(numKeys: "0", combination: [[""]], combinationPins: [[""]], keyWayType: "", hasMk: false, masterKeyLevel: "", masterKey: [""], masterPins1: [[""]], masterPins2: [[""]], subMasterKeys: [""])]
    
    @Published var createJobOn: Bool = false

}

struct createJob: View {
    @State var nSubMK = ""                          //this varaible is the textfield the user needs for the submaster key
    @State var numSubMKeys: [String] = []           //this variable makes a number of textfields appear
    @State var numberSMK: [String] = []
    @State var numSubmasterKeys: [String] = []
    @State var counter = 1
    
    
    
    @State var flagE = false
    @State var errorMessage = ""
    
    
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
    @State var masterKeyLevelValue = "0"                //master key level
    @State var keywayVariable = ""
 
    @State var bottomPinsText = ""
    @State var masterPinsText = ""
    @State var combinationText = ""
    
    
    @State var someKeyGenerator1 = keyGenerator(keyway: "", numChangeKeys: 0, masterKeyLevel: 0)
    
    @State var changeKey1 = [[String]]()
    @State var changePins1 = [[String]]()
    @State var masterKey1 = [String]()
    @State var masterPins1 = [[String]]()
    @State var masterPins2 = [[String]]()
    
    
    @State var viewNum = 0                              //viewNum will be used depending on which master key level is used.
    var body: some View {
        ZStack{
            VStack{
                HStack{ //Component 1 Start
                    Spacer()
                    Text("Keyway Type").padding()
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
                }.background(Image("Background")
                   .scaledToFill()
                   .opacity(0.30))
                
                    
 //Component 1 End
                HStack{ //Component 2 Start
                    Menu{
                        Button("0", action: {masterKeyLevelValue = "0"
                            isOn = false
                            numSubmasterKeys.removeAll()
                            nSubMK = ""
                        })
                        Button("1", action: {masterKeyLevelValue = "1"
                            numSubmasterKeys.removeAll()
                            isOn = true
                            nSubMK = ""
                        })
                        Button("2", action: {masterKeyLevelValue = "2"
                            isOn = true
                        })
                    } label: {
                        Label("Master Key Levels", systemImage: "chevron.down")}
                    Text(masterKeyLevelValue)
                } //Compoenent 2 End
                //Component 3 Start
                TextField("Number of Change Keys", text: $numChangeKeysText)
                    .padding()
                    .frame(width: 300)
                    .border(.blue)
                    .background(.white)
                //Component 3 End
                if(masterKeyLevelValue == "2") //Component 4 Start
                {
                    TextField("Number of Submaster Keys", text: $nSubMK)
                        .padding()
                        .frame(width: 300)
                        .background(.white)
                        .border(.blue)
                        
                    HStack{
                        Button(action: {
                            guard Int(nSubMK) != nil else {
                                nSubMK = ""
                                errorMessage = "A number was not entered in the sub master keys textfield properly. Please enter a positive integer number."
                                flagE = true
                                return}

                            guard Int(nSubMK)! > 0  else {
                                nSubMK = ""
                                errorMessage = "The number entered in change keys sub master is below one. Please enter a positive integer number."
                                flagE = true
                                return}
                            for _ in 1...(Int(nSubMK) ?? 1)
                            {
                                self.numSubmasterKeys.append("")
                            }
                            self.counter = counter + (Int(nSubMK) ?? 1)
                        }){Text("Add Combo")}
                            .frame(width: 175, height: 35, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .foregroundColor(Color.white)
                            .alert(isPresented: $flagE) {Alert(title: Text("Error Message"), message: Text(errorMessage), dismissButton: .default(Text("OK")))}
                        
                        Button(action: {
                            numSubmasterKeys.removeAll()
                        }, label: {Text("Reset")})
                            .padding()
                            .frame(width: 175, height: 35)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                    }

                    
                    //List{
                        ScrollView{
                            VStack{
                               ForEach(0..<numSubmasterKeys.count, id: \.self) {index in
                                    TextField("Num Keys for SMKeys", text: self.$numSubmasterKeys[index])
                                       .padding()
                                       .frame(width: 300)
                                       .border(.blue)
                                       .background(/*.black.opacity(0.1)*/ .white)
                                }
                           }
                        }
                    //}
                }//Component 4 End
                if(kwiksetFlag || schlageFlag)//Component 5 Start
                {
                    Button("Generate", action:{
                        confirmFlag2 = true
                        guard Int(numChangeKeysText) != nil else {
                            confirmFlag2 = false
                            numChangeKeysText = ""
                            errorMessage = "A number was not entered in the change keys textfield properly. Please enter a positive integer number."
                            flagE = true
                            return}

                        guard Int(numChangeKeysText)! > 0  else {
                            confirmFlag2 = false
                            numChangeKeysText = ""
                            errorMessage = "The number entered change keys textfield is below one. Please enter a positive integer number."
                            flagE = true
                            return}
                        
                        someKeyGenerator1 = keyGenerator(keyway: keywayVariable, numChangeKeys: Int(numChangeKeysText) ?? 1, masterKeyLevel: Int(masterKeyLevelValue) ?? 0)
                    
                         if(masterKeyLevelValue == "1")
                         {
                            
                             numberSMK.removeAll()
                             masterKey1.removeAll()
                             changeKey1.removeAll()
                             changePins1.removeAll()
                             masterPins1.removeAll()
                             masterPins2.removeAll()
                             
                             
                             someKeyGenerator1.generateMasterKey() //step 1
                             masterKey1.append(someKeyGenerator1.getMasterKey())
                        
                             someKeyGenerator1.generateChangeKeys() //step 2
                             changeKey1.append(someKeyGenerator1.getChangeKeys())

                             someKeyGenerator1.generateChangePins() //step 3
                             changePins1.append(someKeyGenerator1.getChangePins())
                        
                            someKeyGenerator1.generateMasterPins() //step 4
                             masterPins1.append(someKeyGenerator1.getMasterPins1())
                        }
                        else if(masterKeyLevelValue == "2")
                        {
                            guard Int(nSubMK) != nil else {
                                confirmFlag2 = false
                                nSubMK = ""
                                errorMessage = "A number was not entered in the submaster keys textfield properly. Please enter a positive integer number."
                                flagE = true
                                return}

                            guard Int(nSubMK)! > 0  else {
                                confirmFlag2 = false
                                nSubMK = ""
                                errorMessage = "The number entered in the submaster keys textfield is below one. Please enter a positive integer number."
                                flagE = true
                                return}
                            
                            someKeyGenerator1 = keyGenerator(keyway: keywayVariable, numChangeKeys: Int(numChangeKeysText) ?? 1, masterKeyLevel: Int(masterKeyLevelValue) ?? 0, numSubMasterKeys: Int(nSubMK) ?? 1)

                            var numChangesKeysForEachSubMKs = [Int]() //put the "string integer" variables from numSubMKeys array to numChangesKrysForEachSubMKs
                             
                            for x in 0..<(Int(nSubMK) ?? 1)
                            {
                                guard Int(numSubmasterKeys[x]) != nil else {
                                    confirmFlag2 = false
                                    errorMessage = "A number was not entered in the number key for sub master key textfield list properly for textfield " + String(x+1) +  "." + " Please enter a positive integer number."
                                    flagE = true
                                    return}

                                guard Int(numSubmasterKeys[x])! > 0 else {
                                    confirmFlag2 = false
                                    errorMessage = "The number in the number key for sub master key is not a positive number in textfield " + String(x+1) +  "." + " Please enter a positive integer number."
                                    flagE = true
                                    return}
                                 
                                numChangesKeysForEachSubMKs.append(Int(numSubmasterKeys[x]) ?? 1)
                            }

                            numberSMK.removeAll()
                            masterPins2.removeAll()
                            masterKey1.removeAll()
                            changeKey1.removeAll()
                            changePins1.removeAll()
                            masterPins1.removeAll()
                            
                            
                            someKeyGenerator1.generateMasterKey() //step 1
                            someKeyGenerator1.generateChangeKeys() //step 2
                             
                            someKeyGenerator1.generateChangePins() //step 3
                             
                            someKeyGenerator1.generateMasterPins() //step 4
                            someKeyGenerator1.generateSubMasterKeys() //step 5
                             
                            masterPins2.append(someKeyGenerator1.getMasterPins2())
                            masterKey1.append(someKeyGenerator1.getMasterKey())
                            changeKey1.append(someKeyGenerator1.getChangeKeys())
                            changePins1.append(someKeyGenerator1.getChangePins())
                            masterPins1.append(someKeyGenerator1.getMasterPins1())
                            
                            let subMasterKeys = someKeyGenerator1.getSubMasterKeys()
                            //each sub masterkey will have its own change keys
                            for i in 0..<someKeyGenerator1.getNumSubMasterKeys() {
                                 var subMKSystem = keyGenerator(keyway: keywayVariable, numChangeKeys: numChangesKeysForEachSubMKs[i], masterKeyLevel: 2,
                                     numSubMasterKeys: 0 /*sub MKs dont have subMKs so hardcoded this 0*/,
                                     hasHigherLevelMK: true /*hardcode this to true*/,
                                     GMKSystem: someKeyGenerator1 /*pass in the keyGenerator instance*/)
                                 
                                 subMKSystem.setMasterKey(masterKey: subMasterKeys[i])
                                 subMKSystem.generateChangeKeys()
                                 subMKSystem.generateChangePins()
                                 subMKSystem.generateMasterPins()
                                
                                
                                 
                                 let tempCKs = subMKSystem.getChangeKeys()

                                 for j in 0..<subMKSystem.getChangeKeys().count {
                                     someKeyGenerator1.appendToAllKeys(newKey: tempCKs[j])
                                 }
                                
                                
            
                                masterPins2.append(subMKSystem.getMasterPins2())
                                masterKey1.append(subMKSystem.getMasterKey())
                                changeKey1.append(subMKSystem.getChangeKeys())
                                changePins1.append(subMKSystem.getChangePins())
                                masterPins1.append(subMKSystem.getMasterPins1())
                            }
                            numberSMK = someKeyGenerator1.getSubMasterKeys()
                        }
                        else
                        {
                            numberSMK.removeAll()
                            changeKey1.removeAll()
                            changePins1.removeAll()
                            masterPins2.removeAll()
                            masterKey1.removeAll()
                            masterPins1.removeAll()
                            
                            someKeyGenerator1.generateChangeKeys()
                            changeKey1.append(someKeyGenerator1.getChangeKeys())

                            someKeyGenerator1.generateChangePins()
                            changePins1.append(someKeyGenerator1.getChangePins())
                        }
                        viewNum = 4
                        numberOfLocksCombos = someKeyGenerator1.getAllKeys().count
                    })
                    .frame(width: 250, height: 35, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                    .disabled(keyWayFlag)
                    .alert(isPresented: $flagE) {Alert(title: Text("Error Message"), message: Text(errorMessage), dismissButton: .default(Text("OK")))}
                }
                else{
                    Button("Generate", action:{})
                        .frame(width: 250, height: 35, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(Color.blue)
                        .disabled(keyWayFlag)
                        .border(Color.blue, width: 2)
                }//Component 5 End
                HStack{//Component 6 Start
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
                            if(viewModel.numCombos.count == 1)
                            {
                                viewModel.numCombos.remove(at: 0)
                            }
                            viewNum = Int(masterKeyLevelValue) ?? 0
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
                            .background(.white)
                            .foregroundColor(.blue)
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
                        numChangeKeysText = ""
                        masterKeyLevelValue = "0"
                    }, label: {Text("Reset")})
                        .padding()
                        .frame(width: 175, height: 35)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                    Spacer()
                }//Component 6 End
                HStack{//Component 7 Start
                    Text("Key combo #").foregroundColor(Color.red)
                    Text("Key Pins #").foregroundColor(Color.green)
                    Text("Master combo #").foregroundColor(Color.blue)
                    Text("M Pins L1").foregroundColor(Color.orange)
                    Text("M Pins L2").foregroundColor(Color.brown)
                }
                //Component 7 End
                VStack{
                List{//Component 8 Start
                    if(flag)
                    {
                        ScrollView{
                            if(viewNum == 2)
                            {
                                ForEach(viewModel.numCombos){ num in
                        
                                    numComboRow(numKeys: "",
                                                combo: String(num.combination.joined().joined(separator: ", ")),
                                                comboPins: String(num.combinationPins.joined().joined(separator: ", ")),
                                                keyWay: "",
                                                hasMKValue: String(""), mKeyLevel: "",
                                                masterKey: String(num.masterKey.joined(separator: ", ")),
                                                masterPins1: String(num.masterPins1.joined().joined(separator: ", ")),
                                                masterPins2: String(masterPins2.joined().joined(separator: ", ")),
                                                subMasterKey: "")
                                   
                                }
                            }
                            else if(viewNum == 1)
                            {
                                ForEach(viewModel.numCombos){ num in
                        
                                    numComboRow(numKeys: "",
                                                combo: String(num.combination.joined().joined(separator: ", ")),
                                                comboPins: String(num.combinationPins.joined().joined(separator: ", ")),
                                                keyWay: "",
                                                hasMKValue: String(""), mKeyLevel: "",
                                                masterKey: String(num.masterKey.joined(separator: ", ")),
                                                masterPins1: String(num.masterPins1.joined().joined(separator: ", ")),
                                                masterPins2: String(""),
                                                subMasterKey: String(""))
                                    
                                }
                            }
                            else if(viewNum == 0)
                            {
                                ForEach(viewModel.numCombos){ num in
                        
                                    numComboRow(numKeys: "",
                                                combo: String(num.combination.joined().joined(separator: ", ")),
                                                comboPins: String(""),
                                                keyWay: "",
                                                hasMKValue: String(""), mKeyLevel: "",
                                                masterKey: String(""),
                                                masterPins1: String(""),
                                                masterPins2: String(""),
                                                subMasterKey: String(""))
                                    
                                }
                            }
                        }
                    }
                
                }//Component 8 End
               //Component 9 Start
                    
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
                            masterPins2.removeAll()
                            masterKey1.removeAll()
                            changeKey1.removeAll()
                            changePins1.removeAll()
                            masterPins1.removeAll()
                            numberSMK.removeAll()
                            numSubmasterKeys.removeAll()
                            nSubMK = ""
                            numChangeKeysText = ""
                            masterKeyLevelValue = "0"
                        }), secondaryButton: .cancel(Text("No")))}
                        .padding()
                        .frame(width: 300, height: 35)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
//comp 9 end
                }.background(Image("Background")
                    .scaledToFill()
                    .opacity(0.30))//VSTACK
            }
               
        }
       
    }
    
    func addToList() {
        
        viewModel.createJobOn = true
        
        let newCombo = numCombo(numKeys: String(numberOfLocksCombos), combination: changeKey1, combinationPins: changePins1, keyWayType: keywayVariable, hasMk: isOn, masterKeyLevel: masterKeyLevelValue, masterKey: masterKey1, masterPins1: masterPins1, masterPins2: masterPins2, subMasterKeys: numberSMK)
            
            viewModel.numCombos.append(newCombo)
    }
    
}//End of Struct View

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
    private var masterKeyLevel:Int
    private var numSubMasterKeys:Int
    private var hasHigherLevelMK:Bool
    private var changeKeys = [String]()
    private var changePins = [String]()
    private var masterPins1 = [String]()
    private var masterPins2 = [String]()
    private var subMasterKeys = [String]()
    private var allKeys = [String]()
    private var GMK:String
    private var GMKAllKeys = [String]()

    /*constructor: generate change keys w/ a master key*/
    init(keyway:String, numChangeKeys:Int, masterKeyLevel:Int, numSubMasterKeys: Int = 0) {
        masterKey = ""
        self.numChangeKeys = numChangeKeys
        self.keyway = keyway
        self.masterKeyLevel = masterKeyLevel
        self.numSubMasterKeys = numSubMasterKeys
        changeKeys = [String](repeating: "", count: numChangeKeys)
        changePins = [String](repeating: "", count: numChangeKeys)
        masterPins1 = [String](repeating: "", count: numChangeKeys) //JIRA
        masterPins2 = [String](repeating: "", count: numChangeKeys)
        subMasterKeys = [String](repeating: "", count: numSubMasterKeys)
        hasHigherLevelMK = false
        GMK = ""
        GMKAllKeys = [""]
    }

/*second constructor: for sub master keys*/
    init(keyway:String, numChangeKeys:Int, masterKeyLevel:Int, numSubMasterKeys: Int, hasHigherLevelMK: Bool, GMKSystem: keyGenerator) {
        masterKey = ""
        self.numChangeKeys = numChangeKeys
        self.keyway = keyway
        self.masterKeyLevel = masterKeyLevel
        self.numSubMasterKeys = numSubMasterKeys
        self.hasHigherLevelMK = hasHigherLevelMK
        changeKeys = [String](repeating: "", count: numChangeKeys)
        changePins = [String](repeating: "", count: numChangeKeys)
        masterPins1 = [String](repeating: "", count: numChangeKeys)
        masterPins2 = [String](repeating: "", count: numChangeKeys)
        subMasterKeys = [String](repeating: "", count: numSubMasterKeys)
        GMK = GMKSystem.getMasterKey()
        GMKAllKeys = GMKSystem.getAllKeys()
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
            allKeys.append(self.masterKey)
        }
        else {
            print("master key is not correct length or doesn't satisfy macs value.")
        }
    }
    
    func setNumChangeKeys(numChangeKeys:Int) {
        self.numChangeKeys = numChangeKeys
    }

    func getNumSubMasterKeys() -> Int {
        return numSubMasterKeys
    }
    
    func getKeyway() -> String {
        return keyway
    }

    func getMasterKeyLevel() -> Int {
        return masterKeyLevel
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
    
    func getMasterPins1() -> [String] {
        return masterPins1
    }
    
    func getMasterPins2() -> [String] {
        return masterPins2
    }
    
    func getSubMasterKeys() -> [String] {
        return subMasterKeys
    }
    
    func getAllKeys() -> [String] {
        return allKeys
    }
    
    func appendToAllKeys(newKey: String) {
        allKeys.append(newKey)
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
        allKeys.append(masterKey)
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
            
            //generate the change keys
            for i in 0..<numChangeKeys {
                randomCK = Int.random(in: 0..<(allViableKeys.count))
                if (hasHigherLevelMK == true) {
                    while(GMKAllKeys.contains(String(allViableKeys[randomCK]))) {
                        randomCK = Int.random(in: 0..<(allViableKeys.count))
                    }
                }
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
        allKeys.append(contentsOf: changeKeys)
    }
    
    /*generates the subMasterKeys*/
    func generateSubMasterKeys() {
        var viableSubMK:Bool
        var randomChamber:Int = 0
        var randomCut:Int = 0
        var tempKey:String
        
        var mkCutIndex:String.Index
        var mkCut:Int
        
        for i in 0..<numSubMasterKeys {
            viableSubMK = false
            while(viableSubMK == false) {
                tempKey = ""
                randomChamber = Int.random(in: 0..<combinationLength)
                randomCut = Int.random(in: getMinDepth()...getMaxDepth())
                
                mkCutIndex = (masterKey).index(masterKey.startIndex, offsetBy: randomChamber)
                mkCut = Int(masterKey[mkCutIndex...mkCutIndex]) ?? 0
                if (((mkCut % 2) == (randomCut % 2)) && (mkCut != randomCut)) {
                    for keyChamber in 0..<combinationLength {
                        if(keyChamber == randomChamber) {
                            tempKey += String(randomCut)
                        }
                        else {
                            mkCutIndex = (masterKey).index(masterKey.startIndex, offsetBy: keyChamber)
                            mkCut = Int(masterKey[mkCutIndex...mkCutIndex]) ?? 0
                            tempKey += String(mkCut)
                        }
                    }
                    if(checkMACSValue(key: tempKey) && hasLowestDepth(masterKey: tempKey) && !allKeys.contains(tempKey)) {
                        viableSubMK = true
                        subMasterKeys[i] = tempKey
                    }
                }
            }
        }
        allKeys.append(contentsOf: subMasterKeys)
    }

    /*generate bottom (change key) pins*/
    func generateChangePins() {
        var ckCutIndex:String.Index
        var mkCutIndex:String.Index
        var gmkIndex:String.Index
        var ckCut:Int
        var mkCut:Int
        var gmkCut:Int
        var smallestCut:Int

        for i in 0..<numChangeKeys {
            if(masterKey.isEmpty == false) {
                for j in 0..<combinationLength {
                    ckCutIndex = (changeKeys[i]).index((changeKeys[i]).startIndex, offsetBy: j)
                    ckCut = Int((changeKeys[i])[ckCutIndex...ckCutIndex]) ?? 0
                    mkCutIndex = (masterKey).index(masterKey.startIndex, offsetBy: j)
                    mkCut = Int(masterKey[mkCutIndex...mkCutIndex]) ?? 0
                    
                    //find smallest cut for current chamber
                    smallestCut = ckCut
                    if(mkCut < smallestCut) {
                        smallestCut = mkCut
                    }
                    if(hasHigherLevelMK == true) {
                        gmkIndex = GMK.index(GMK.startIndex, offsetBy: j)
                        gmkCut = Int(GMK[gmkIndex...gmkIndex]) ?? 0
                        if(gmkCut < smallestCut) {
                            smallestCut = gmkCut
                        }
                    }
                    changePins[i] += String(smallestCut)
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
        var gmkCutIndex:String.Index
        var ckCut:Int
        var mkCut:Int
        var gmkCut:Int
        var pin:Int
        var masterPin1:String
        var masterPin2:String
        var currentCuts = [Int]()
        
        for i in 0..<numChangeKeys {
            masterPin1 = ""
            masterPin2 = ""

            for j in 0..<combinationLength {
                ckCutIndex = (changeKeys[i]).index(changeKeys[i].startIndex, offsetBy: j)
                ckCut = Int((changeKeys[i])[ckCutIndex...ckCutIndex]) ?? 0
                mkCutIndex = (masterKey).index(masterKey.startIndex, offsetBy: j)
                mkCut = Int(masterKey[mkCutIndex...mkCutIndex]) ?? 0
                
                //generate the master pins
                if(hasHigherLevelMK == false) {
                    pin = abs(mkCut - ckCut)
                    masterPin1 += String(pin)
                    masterPin2 += "0"
                }
                else {
                    gmkCutIndex = GMK.index(GMK.startIndex, offsetBy: j)
                    gmkCut = Int(GMK[gmkCutIndex...gmkCutIndex]) ?? 0
                    
                    currentCuts.append(ckCut)
                    currentCuts.append(mkCut)
                    currentCuts.append(gmkCut)
                    currentCuts.sort()
                    
                    pin = currentCuts[1] - currentCuts[0]
                    masterPin1 += String(pin)
                    
                    pin = currentCuts[2] - currentCuts[1]
                    masterPin2 += String(pin)
                    
                    currentCuts.removeAll()
                }
            }
            masterPins1[i] = masterPin1
            masterPins2[i] = masterPin2
        }
    }
}

struct numComboRow: View{
    let numKeys: String
    let combo: String
    let comboPins: String
    let keyWay: String
    let hasMKValue: String
    let mKeyLevel: String
    let masterKey: String
    let masterPins1: String
    let masterPins2: String
    let subMasterKey: String
    var body: some View{
        HStack{
            Text(numKeys)
            Text(combo).foregroundColor(Color.red)
            Text(comboPins).foregroundColor(Color.green)
            Text(keyWay)
            Text(hasMKValue)
            Text(mKeyLevel)
            Text(masterKey).foregroundColor(Color.blue)
            Text(masterPins1).foregroundColor(Color.orange)
            Text(masterPins2).foregroundColor(Color.brown)
            Text(subMasterKey)
        }
    }
    
}
/*
struct CreateJobView_Previews: PreviewProvider {
    static var previews: some View {
        createJob(viewModel: <#numComboViewModel#>)
    }
}

*/
