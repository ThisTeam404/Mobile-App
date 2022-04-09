//  TextFieldView.swift
//  TextFieldView
//
//  Created by Matthew Murata on 4/7/22.
//

import SwiftUI

struct TextFieldView: View {
    @State private var apiKey = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Form{
                Section(header: Text("Enter API Key")){
                    TextField("API Key", text: $apiKey)
                        .padding()
                        .border(.blue)
                        .background(.black.opacity(0.1))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}


// Hides keyboard when done using it, 
// doesn't seem to work?
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

