//
//  JobDetailsView.swift
//  GoogleLoginOption
//
//  Created by Milford Gover and Kaily Estepa on 4/3/22.
//

import SwiftUI

class JobDetails: ObservableObject, Codable{
    enum CodingKeys: CodingKey{
        case jobCost, jobAddy, jobDate, jobNotes
    }
    
    @Published var jobCost = ""
    @Published var jobAddy = ""
    @Published var jobDate = ""
    @Published var jobNotes = ""
    
    init(){}
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(jobDate, forKey: .jobDate)
        try container.encode(jobCost, forKey: .jobCost)
        try container.encode(jobAddy, forKey: .jobAddy)
        try container.encode(jobNotes, forKey: .jobNotes)
    }
    
    required init(from decoder: Decoder) throws{
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        jobDate = try container.decode(String.self, forKey: .jobDate)
        jobCost = try container.decode(String.self, forKey: .jobCost)
        jobAddy = try container.decode(String.self, forKey: .jobAddy)
        jobNotes = try container.decode(String.self, forKey: .jobNotes)

    }
}

struct JobDetailsView: View {
    @State var jobNotes: String = "N/A"
    @ObservedObject var details: JobDetails
    
    var body: some View {
        
        VStack(alignment: .center){
            
            VStack{
            
                Text("Job Details")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                TextField("Cost ", text: $details.jobCost)
                    .padding()
                    .frame(width: 350)
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                

                
                TextField("Date ", text: $details.jobDate)
                    .padding()
                    .frame(width: 350)
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                

                
                TextField("Address ", text: $details.jobAddy)
                    .padding()
                    .frame(width: 350)
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                
            }.offset(y:75)
            
            Spacer()
            
            VStack{
                
                Text("Job Notes")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                ZStack{
                    TextEditor(text: $jobNotes)
                        .border(.blue)
                        .frame(width: 350, height: 385)
                    
                    Text("Job Notes")
                        .opacity(0)
                        .padding(.all, 8)
                }
                .shadow(radius: 5)
                
                Button("Export"){
                    Task{
                        details.jobNotes=jobNotes
                        await export()
                    }
                }.padding()
                    .frame(width: 175, height: 40)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
            }
            .offset(y:35)
            Spacer()
            
        }.background(Image("Background")
            .resizable()
            .scaledToFill()
            .clipped()
            .opacity(0.25))
        .edgesIgnoringSafeArea([.top, .bottom])
    }
    
    func export() async{
        
        guard let encoded = try? JSONEncoder().encode(details) else{
            print("Failed to encode order")
            return
        }
        
        //URLRequest: httpMethod shows how to be sent POST to write GET to read; mimetype application/json
        
        guard let url = URL(string: "https://web-login-test1.herokuapp.com/createNewTuple") else {return}
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            print("here")
            
            //send encoded data
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
           
            //handle result and response
            
            let decodedDetails = try JSONDecoder().decode(JobDetails.self, from: data)
            
            print("Job Date: \(decodedDetails.jobDate)")
            print("Cost: \(decodedDetails.jobCost)")
            print("Address: \(decodedDetails.jobAddy)")
            print("Notes: \(decodedDetails.jobNotes)")
        }catch{
            print("ERROR")
        }
        
    }
    
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(details: JobDetails())
    }
}
