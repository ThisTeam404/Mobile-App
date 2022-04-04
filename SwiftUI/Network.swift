//
//  Network.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 3/11/22.
//

import Foundation

struct TestData: Codable{
    let data: String
}


class Network: ObservableObject{
    
    @Published var loading = false
    
    init(){
        self.loading = true
        connectToServer()
    }
    
    private func connectToServer(){
        print("executing connection")
        
          //checking connection
         guard let url = URL(string: "https://web-login-test1.herokuapp.com/createNewTuple") else {return}
         let request = URLRequest(url: url)
         URLSession.shared.dataTask(with: request){(data, response, err) in
             guard err == nil && data != nil else{
                 if err?.localizedDescription.range(of: "Could not connect to the server.") != nil {
                     print("COULD NOT CONNECT TO SERVER")
                 } else if err?.localizedDescription.range(of: "A server with the specified hostname could not be found.") != nil {
                     print("HOST NAME NOT FOUND")
                 }
                 return
             }
             guard response != nil else{
                 print("RESPONSE IS NIL")
                 return
             }
         }.resume()
        
        //if no error occurs
        self.loading.toggle()
        print("connected")
    }
    
    //testing: send data to server
    func getData(){
        //Prepare URL -- connects to endpoint on the server
        guard let url = URL(string: "https://web-login-test1.herokuapp.com/sendSecretStuffWithReturn") else { return }
        
        //Encode data to be sent
        let sendData = TestData(data: "thisIsMyNewString")
        
        guard let uploadData = try? JSONEncoder().encode(sendData) else { return }
        
        //Prepare URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Perform HTTP Request
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) {data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
            print("cleared")
            
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print("Response data string: \n \(dataString)")
            }
            
        }
        task.resume()
       
       print("sent")
 
    }
        
}
