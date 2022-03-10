//
//  JobDetailsView.swift
//  LockThatDown
//
//  Created by Hansen, Nicole Alexis on 3/9/22.
//

import SwiftUI

struct JobDetailsView: View {
    @State var jobCost = ""
    @State var jobAddy = ""
    @State var jobDate = ""
    @State var jobNotes = ""
    
    
    var body: some View {
        VStack(alignment: .center){
            
            Text("Job Details")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.cyan)
            
            TextField("Cost ", text: $jobCost)
                .padding()
            TextField("Date ", text: $jobDate)
                .padding()
            TextField("Address ", text: $jobAddy)
                .padding()
         
            Text("Job Notes")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            ZStack{
                TextEditor(text: $jobNotes).border(Color.cyan)
                Text(jobNotes).opacity(0).padding(.all, 8)
            }
            .shadow(radius: 1)
        }
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView()
    }
}
