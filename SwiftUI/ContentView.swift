//
//  ContentView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginVM: LoginViewModel
    @ObservedObject var networkModel = Network()
    
    var body: some View {
        return Group{
            //if able to login
            if(loginVM.successfulLogin){
                if(!networkModel.loading)
                {
                    MenuView()
                }
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

