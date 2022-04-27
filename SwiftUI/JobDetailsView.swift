//
//  JobDetailsView.swift
//  GoogleLoginOption
//
//  Created by Milford Gover on 4/3/22.
//

import SwiftUI

struct JobDetailsView: View {
    
    @ObservedObject var details = JobDetails()
    
    @State var textCost = ""
    @State var textAddress = ""
    @State var textNotes = ""
    
    
    var body: some View {
        
        VStack(alignment: .center){
        ScrollView{
            VStack{
            
                Text("Job Details")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("Cost ", text: $textCost)
                    .padding()
                    .frame(width: 350)
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                
                TextField("Address ", text: $textAddress)
                    .padding()
                    .frame(width: 350)
                    .background(.black.opacity(0.1))
                    .border(.blue.opacity(0.8))
                    .offset(y: 5)
                
                
            }.offset(y:75)
            
            Spacer()
            
            VStack{
                
                Text("Job Notes")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                ZStack{
                    TextEditor(text: $textNotes)
                        .border(.blue)
                        .frame(width: 350, height: 385)
                    
                    Text("Job Notes")
                        .opacity(0)
                        .padding(.all, 8)
                }
                .shadow(radius: 5)
                
                    Button("Save", action:{
                        self.save()
                    }).padding()
                    .frame(width: 300, height: 40)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(15)
                    .offset(y:15)
            }
            .offset(y:85)
            Spacer()
        }
        }.background(Image("Background")
            .resizable()
            .scaledToFill()
            .clipped()
            .opacity(0.30))
        .edgesIgnoringSafeArea([.top, .bottom])
    }
    
    func save(){
    
        details.jobCost = textCost
        print(details.jobCost)
        details.jobAddress = textAddress
        print(details.jobAddress)
        details.jobNotes = textNotes
        print(details.jobNotes)
  
        
        //clear
        textCost = ""
        textAddress = ""
        textNotes = ""
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(details: JobDetails())
    }
}


/*
struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(details: JobDetails())
    }
}
*/
