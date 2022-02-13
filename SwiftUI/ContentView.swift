//
//  ContentView.swift
//  LockThatDown
//
//  Created by Milford Gover on 2/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var signInSuccess = false
    @State var changeView = false
    var body: some View {
        return Group{
            if signInSuccess && !changeView {
                createJob(changeView:$changeView)

            }
            else if signInSuccess && changeView{
                createLockView(changeView:$changeView)
            }
            else if !signInSuccess{
                LoginFormView(signInSuccess: $signInSuccess)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11 Pro")
                .previewInterfaceOrientation(.portrait)
        }
    }
}
