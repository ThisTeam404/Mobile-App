//
//  NotesView.swift
//  GoogleLoginOption
//
//  Created by Matthew Murata and Kaily Estepa on 3/22/22.
//
import SwiftUI

class setApiKey: ObservableObject{
    @Published var enterApiKey = "insertApiKey"
}

struct ApiView: View {
    
    @ObservedObject var setApi: setApiKey
    @State var apiKey = ""
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .scaledToFill()
                .opacity(0.30)
                .ignoresSafeArea()
            VStack(){
                Text("Enter API Key")
                    .frame(width: 330, height: 50, alignment: .leading)
                
                TextField("API Key", text: $apiKey)
                    .frame(width: 300, height: 20, alignment: .leading)
                    .padding()
                    .border(.blue)
                    .background(.black.opacity(0.1))
                    .accessibilityIdentifier("APIKey")
                
                //assign
                Button("Send", action:{
                    sendApiKey()
                }).frame(width: 300, height: 40, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .accessibilityIdentifier("Send")
                
                Spacer()
            }.offset(y:10)
        }
            
    }
    func sendApiKey(){
        setApi.enterApiKey = apiKey
        print("\(setApi.enterApiKey) entered")
        apiKey = " "
              
    }
    
}
/*
struct ApiView_Previews: PreviewProvider {
    static var previews: some View {
        ApiView()
    }
}*/
