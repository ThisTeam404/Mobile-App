//
//  LoginView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        ZStack{
            
            Color
                .blue.opacity(0.9)
                .ignoresSafeArea()
            
            Circle()
                .scale(1.1)
                .foregroundColor(.white)
            
            Circle()
                .scale(1.1)
                .foregroundColor(.blue.opacity(0.3))
            
            Circle()
                .scale(1.0)
                .foregroundColor(.white)
            
            
            VStack {
                
                Text("Lock That Down")
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 160.0, height: 50.0)
                
                
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
                
                Button("Login ", action:{
                    print("sign in with google")
                })
                    .offset(x: -80)
                
                Button("Google Sign In ", action:{
                    loginVM.signUpWithGoogle()
                })
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


