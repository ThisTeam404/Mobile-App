//
//  LoginFormView.swift
//  LockThatDown
//
//  Created by Estepa, Kaily on 2/12/22.
//

import SwiftUI

struct LoginFormView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    
    @State private var showError = false
    
    @Binding var signInSuccess: Bool
    
    var body: some View {
        
        ZStack{
            Color
                .blue.opacity(0.9)
                .ignoresSafeArea()
            Circle()
                .scale(1.1)
                .foregroundColor(.white)
                .offset(x: 0,y: 0.0)
            VStack {
                Text("Lock That Down")
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 200.0, height: 50.0)
                
                Text("User Name")
                TextField("type here", text: $userName)
                    .padding(.all)
                    .frame(width: 200.0, height: 50.0)
                    .border(Color.blue)
                    .background(Color.black.opacity(0.05))
                
                
                
                Text(" Password")
                SecureField("type here", text: $password).textContentType(.password)
                    .padding(.all)
                    .frame(width: 200.0, height: 50.0)
                    .border(Color.blue)
                    .background(Color.black.opacity(0.05))
                
                Button(action: {
                    if(self.userName == self.password){
                        self.signInSuccess = true
                    }
                    else{
                        self.showError = true
                    }
                }) {
                    Text("sign in")
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    
                if showError{
                    Text("Incorrect username/pass").foregroundColor(Color.red)
                }
            }
        }
    }
}
/*
struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView()
    }
}
*/
