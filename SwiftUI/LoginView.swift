//
//  LoginView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
 
    
    var body: some View {
        
        ZStack{
            Color
                .blue
                .opacity(0.8)
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
            
            VStack{
                Text("WELCOME")
                    .font(.largeTitle)
                    .italic()
                    .padding()
                    .offset(x: 0, y: -50)
                    .foregroundColor(.white)
                
                Image("Logo")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 350, height: 350)
                    .offset(x: 0, y: -10)
                
                Button("Google Sign In ", action:{
                    loginVM.signUpWithGoogle()
         
                })
                    .padding()
                    .foregroundColor(.blue)
                    .background(.white)
                    .cornerRadius(20)
                    .offset(x: 0, y: 35)
                    .accessibilityIdentifier("GoogleSignIn")
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
