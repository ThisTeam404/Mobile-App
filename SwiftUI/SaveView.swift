//
//  SaveView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 4/7/22.
//

import SwiftUI


//from job details and add lock
struct JobInfo: Codable{
    var numkeys: String = ""
    var cost: String = ""
    var address: String = ""
    var notes: String = ""
}

struct KeyInfo: Codable, Identifiable{
    var id = UUID()
  
    var keyway: String = "" // addlock and createjob
    var combination: String = "" //addlock(bitting) and createjob
    var unit: String = "" //addlock
    var bottomPins: String = "" //createjob
    var hasMK: Bool = false
    var keyLevelType: String = "" //createjob if add lock = CK
    var MKCombination: String = "" //createjob and addlock?
    var masterPins1: String = "" //createjob and Add Lock
    var masterPins2: String = "" //createjob
}

class AllInfo: Codable{
    var job: JobInfo
    var keys: [KeyInfo] = []
    var apiKey: String = ""
    
    init(){
        self.job = JobInfo()
        self.keys = []
    }
}

class FinalArray: ObservableObject, Codable{
    enum CodingKeys: CodingKey{
     case finalArray
    }
    
    @Published var finalArray: AllInfo

    init(){
        
        self.finalArray = AllInfo()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(finalArray, forKey: .finalArray)
    }
    
    required init(from decoder: Decoder) throws{
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        finalArray = try container.decode(AllInfo.self, forKey: .finalArray)
    }
}

//NOTE: make sure to clear after sending to db
struct SaveView: View {
    
    //get info from other view
    @ObservedObject var jobDetails: JobDetails
    @ObservedObject var addLockDetails : LocksViewModel
    @ObservedObject var createJobDetails: numComboViewModel
    @ObservedObject var apiKeyInfo: setApiKey
    
    //final info
    @ObservedObject var finalInfo: FinalArray
    
    @State var addKeyWay: String = ""
    @State var addCombination: String = ""
    @State var addUnitNum: String = ""
    @State var addBottomPins: String = ""
    @State var addHasMK: Bool = false
    @State var addKeyLevelType: String = ""
    @State var addMKCombo: String = ""
    @State var addMPins1: String = ""
    @State var addMPins2: String = ""
    @State var ifSave: Bool = false
    @State var ifCancel: Bool = false
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .scaledToFill()
                .opacity(0.30)
                .ignoresSafeArea()
            
            VStack{
                if(!ifSave){
                    Button("Load Data", action:{
                        save()
                        ifSave = true
                    })
                    .frame(width: 200, height: 40)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(15)
                }
                else{
                    ScrollView(showsIndicators: false){
                        
                        VStack(alignment: .leading){
                            Text("Job Information")
                                .bold()
                            
                            Text("Cost: \(finalInfo.finalArray.job.cost)")
                            Text("Address: \(finalInfo.finalArray.job.address)")
                            Text("Notes: \(finalInfo.finalArray.job.notes)")
                            Text("Num Keys: \(finalInfo.finalArray.job.numkeys)")
                            
                            Text("")
                            Text("Keys")
                                .bold()
                            
                            ForEach(finalInfo.finalArray.keys){ keyInfo in
                                Text("")
                                Text("KeyWay: \(keyInfo.keyway)")
                                Text("Combination: \(keyInfo.combination)")
                                Text("Unit: \(keyInfo.unit)")
                                Text("Key Level: \(keyInfo.keyLevelType)")
                                Text("Has MK: \(String(keyInfo.hasMK))")
                                Text("Bottom Pins: \(keyInfo.bottomPins)")
                                Text("Master Key Combo:\(keyInfo.MKCombination)")
                                Text("Master Pins1: \(keyInfo.masterPins1)")
                                Text("Master Pins2: \(keyInfo.masterPins2)")}
                        }
                    }.offset(x: -30, y:15)
                    
                   HStack {
                    Button("Save"){
                        Task{
                            printAllInfo()
                            print("exporting...")
                            await export()
                        }
                        ifSave = false
                    }.frame(width: 175, height: 40)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                       
                       Button("Cancel", action:{
                           ifCancel = true
                       })
                           .alert(isPresented: $ifCancel) {Alert(title: Text("Cancel?"), message: Text("Are you sure you want to erase information?"), primaryButton: .default(Text("Yes"), action: {
                               
                               jobDetails.numkeys = ""
                               jobDetails.jobCost = ""
                               jobDetails.jobAddress = ""
                               jobDetails.jobNotes = ""
                               
                               finalInfo.finalArray.apiKey = ""
                               finalInfo.finalArray.job.cost = ""
                               finalInfo.finalArray.job.address = ""
                               finalInfo.finalArray.job.notes = ""
                               finalInfo.finalArray.job.numkeys = ""
                               finalInfo.finalArray.keys.removeAll()
                               
                           }), secondaryButton: .cancel(Text("No")))}
                           .padding()
                           .frame(width: 175, height: 40)
                           .foregroundColor(.white)
                           .background(.blue)
                           .cornerRadius(15)
                        
                    }
                }
            }
        }
    }
    
    func save(){
        printJobInfo()
        printKeyInfo()
    }
    
    func printJobInfo (){
        print("displaying job info")
            Swift.print(jobDetails.jobCost)
        finalInfo.finalArray.job.cost = jobDetails.jobCost
            Swift.print(jobDetails.jobAddress)
        finalInfo.finalArray.job.address = jobDetails.jobAddress
            Swift.print(jobDetails.jobNotes)
        finalInfo.finalArray.job.notes = jobDetails.jobNotes
            Swift.print(jobDetails.numkeys)
        finalInfo.finalArray.job.numkeys = jobDetails.numkeys
        
    }
    
    func printKeyInfo(){
        
        print("displaying key info")
        if(addLockDetails.addLockOn){
            
            print("accessing add lock page")
           
            for lock in addLockDetails.locks{
                Swift.print(lock.keyWay)
                addKeyWay = lock.keyWay
                Swift.print(lock.bitting)
                addCombination = lock.bitting
                Swift.print(lock.unitNum)
                addUnitNum = lock.unitNum
                addKeyLevelType = "CK"
                addMPins1 = lock.mPins
                
                let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: addUnitNum, bottomPins: "", hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: "", masterPins1: addMPins1, masterPins2: "")
                finalInfo.finalArray.keys.append(newKey)
            }
            
            addLockDetails.addLockOn = false
            print("add lock page done")
            
        }else if(createJobDetails.createJobOn){
             
            print("accessing create job page")

            for numCombo in createJobDetails.numCombos{
                
                var row: Int = 0
                
                finalInfo.finalArray.job.numkeys = numCombo.numKeys
                print("Num Keys: \(finalInfo.finalArray.job.numkeys)")
               
                if(numCombo.hasMk){
                    if(numCombo.masterKeyLevel == "1"){
                        print("ASSIGNING W MASTER KEY LEVEL 1")
                        var incCol: Int = 0
                        let limit = Int(numCombo.numKeys)!-1
                        
                        //assign master key as its own instance then read array
                        print("MASTER KEY:")
                        addKeyWay = numCombo.keyWayType
                        addCombination = numCombo.masterKey[0]
                        addKeyLevelType = "MK"
                        addHasMK = false
                        
                        let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: "", bottomPins: "", hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: "", masterPins1: "", masterPins2: "")
                        
                        finalInfo.finalArray.keys.append(newKey)
                        
                        repeat{
                            addHasMK = true
                            
                            addKeyWay = numCombo.keyWayType
                            addCombination = numCombo.combination[0][incCol]
                            addBottomPins = numCombo.combinationPins[0][incCol]
                            addHasMK = numCombo.hasMk
                            addKeyLevelType = "CK"
                            addMKCombo = numCombo.masterKey[0]
                            addMPins1 = numCombo.masterPins1[0][incCol]
                            
                            let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: "", bottomPins: addBottomPins, hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: addMKCombo, masterPins1: addMPins1, masterPins2: "")
                            
                            finalInfo.finalArray.keys.append(newKey)
                            
                            incCol += 1
                            
                        }while(incCol < limit)
                    }
                    else if(numCombo.masterKeyLevel == "2"){
                        
                        var col: Int = 0
                        
                        print("ASSIGNING W MASTER KEY LEVEL 2")
                        print("NUM OF SUBKEYS: \(numCombo.subMasterKeys.count)")
                        repeat{
                            
                            if(row == 0){
                            print("Master Key: \(numCombo.masterKey[row])")
                                
                                addKeyWay = numCombo.keyWayType
                                addCombination = numCombo.masterKey[row]
                                addKeyLevelType = "GMK"
                                addHasMK = false
                                
                                let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: "", bottomPins: "", hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: "", masterPins1: "", masterPins2: "")
                                
                                finalInfo.finalArray.keys.append(newKey)
                            }
                            else{
                                addKeyWay = numCombo.keyWayType
                                addCombination = numCombo.masterKey[row]
                                addKeyLevelType = "MK"
                                addHasMK = true
                                addMKCombo = numCombo.masterKey[0]
                                
                                let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: "", bottomPins: "", hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: addMKCombo, masterPins1: "", masterPins2: "")
                                
                                finalInfo.finalArray.keys.append(newKey)
                            }
                            
                            repeat{
                                
                                addHasMK = true
                                
                                print("KeyWay: \(numCombo.keyWayType)")
                                addKeyWay = numCombo.keyWayType
                                print("Combination: \(numCombo.combination[row][col])")
                                addCombination = numCombo.combination[row][col]
                                print("Bottom Pins: \(numCombo.combinationPins[row][col])")
                                addBottomPins = numCombo.combinationPins[row][col]
                                print("Has Mk: \(numCombo.hasMk)")
                                addHasMK = numCombo.hasMk
                                print("Master Key Level: \(numCombo.masterKeyLevel)")
                                addKeyLevelType = "CK"
                                if(row == 0){
                                    print("Master Key: \(numCombo.masterKey[row])")
                                    addMKCombo = numCombo.masterKey[row]
                                }
                                else{
                                    print("Master Key: \(numCombo.masterKey[row])")
                                    addMKCombo = numCombo.masterKey[row]
                                }
                                print("Master Pin 1: \(numCombo.masterPins1[row][col])")
                                addMPins1 = numCombo.masterPins1[row][col]
                                print("Master Pin 2: \(numCombo.masterPins2[row][col])")
                                addMPins2 = numCombo.masterPins2[row][col]
                                
                                let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: "", bottomPins: addBottomPins, hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: addMKCombo, masterPins1: addMPins1, masterPins2: addMPins2)
                                
                                finalInfo.finalArray.keys.append(newKey)
                                
                                col += 1
                            }while(col < numCombo.combination[row].count)
                            
                            col = 0
                            row += 1
                        }while(row <= numCombo.subMasterKeys.count)
                        
                    }
                    else{
                        print("NOT A MASTER KEY: ERROR")
                    }
                }
                else{
                    print("ASSIGNING A NORMAL KEY")
                    var inc: Int = 0
                    repeat{
                        
                        addKeyLevelType = "CK"
                        
                        addKeyWay = numCombo.keyWayType
                        addCombination = numCombo.combination[0][inc]
                        addBottomPins = numCombo.combinationPins[0][inc]
                        addHasMK = numCombo.hasMk
                        
                        let newKey = KeyInfo(keyway: addKeyWay, combination: addCombination, unit: "", bottomPins: addBottomPins, hasMK: addHasMK, keyLevelType: addKeyLevelType, MKCombination: "", masterPins1: "", masterPins2: "")
                        
                        finalInfo.finalArray.keys.append(newKey)
                        
                        inc += 1
                    }while(inc < Int(numCombo.numKeys) ?? 0)
                }
            }
            
              createJobDetails.createJobOn = false
              print("create job page done")
        }else{
            print("error\n");
        }
    }
    
    func printAllInfo(){
        finalInfo.finalArray.apiKey = apiKeyInfo.enterApiKey
        print("API KEY: \(finalInfo.finalArray.apiKey)")
        print("display job and key info")
            print("Job Cost: \(finalInfo.finalArray.job.cost)")
            print("Job Address: \(finalInfo.finalArray.job.address)")
            print("Job Notes: \(finalInfo.finalArray.job.notes)")
            print("Num Keys: \(finalInfo.finalArray.job.numkeys)")
        
        for keyInfo in finalInfo.finalArray.keys{
            print("-----------------------------------------")
            print("KeyWay: \(keyInfo.keyway)")
            print("Combination: \(keyInfo.combination)")
            print("Unit: \(keyInfo.unit)")
            print("Key Level: \(keyInfo.keyLevelType)")
            print("Has MK: \(keyInfo.hasMK)")
            print("Bottom Pins: \(keyInfo.bottomPins)")
            print("Master Key Combo:\(keyInfo.MKCombination)")
            print("Master Pins1: \(keyInfo.masterPins1)")
            print("Master Pins2: \(keyInfo.masterPins2)")
            print("-----------------------------------------")
        }
    }
    
    func export() async{
        
        guard let encoded = try? JSONEncoder().encode(finalInfo) else{
            print("Failed to encode info")
            return
        }
        
        //URLRequest: httpMethod shows how to be sent POST to write GET to read; mimetype application/json
        
        guard let url = URL(string: "https://web-login-test1.herokuapp.com/createNewTuple") else {return}
        /*guard let url = URL(string: "https://web-login-test1.herokuapp.com/createNewTupleWithAPIKey")
        else{return}*/
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            print("here")
            
            //send encoded data
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //handle result
            let dataString = String(data: data, encoding: .utf8)
            print("Response data string: \n \(String(describing: dataString))")
            
            
        }catch{
            print("ERROR")
        }
        
        jobDetails.numkeys = ""
        jobDetails.jobCost = ""
        jobDetails.jobAddress = ""
        jobDetails.jobNotes = ""
        
        finalInfo.finalArray.apiKey = ""
        finalInfo.finalArray.job.cost = ""
        finalInfo.finalArray.job.address = ""
        finalInfo.finalArray.job.notes = ""
        finalInfo.finalArray.job.numkeys = ""
        finalInfo.finalArray.keys.removeAll()
    }

}
