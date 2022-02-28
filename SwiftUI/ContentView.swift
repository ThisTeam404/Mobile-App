//
//  ContentView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        return Group{
            if(loginVM.successfulLogin){
                MenuView()
            }
            else{
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
           Group{
               ContentView()
               
           }
    }
}
