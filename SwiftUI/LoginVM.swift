//
//  LoginVM.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

class LoginViewModel: ObservableObject{
    
    @Published var successfulLogin: Bool = false
    @Published var userInfo: String = ""
    
    func signUpWithGoogle(){
        
        //Get Application Client ID
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        //Get Configuration
        let config = GIDConfiguration(clientID: clientId)
        
        //GoogleSignIn -- two parameters: the firebase config and the current view
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.rootViewController){
            [self] user, err in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            //authentication , authenticates user/client
            //token acquired from google sent to the Firebase Authentication, which will be verified
            //returns repose to client
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ result, error in
                
                if let err = error {
                    print(err.localizedDescription)
                    return
                    
                }
                
                guard let user = result?.user else { return }
                print(user.displayName!)
                self.userInfo = user.displayName! 
                self.successfulLogin.toggle()
            }
        }
    }
    
    func signOut(){
        
        GIDSignIn.sharedInstance.signOut()
        try? Auth.auth().signOut()
        
        withAnimation{
            self.successfulLogin.toggle()
        }
    }
}
