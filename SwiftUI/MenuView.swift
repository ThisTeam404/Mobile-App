//
//  MenuView.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/24/22.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var signOutOption: LoginViewModel

    @StateObject var details = JobDetails()
    @StateObject var allInfo = FinalArray()
    @StateObject var addLockDetails = LocksViewModel()
    @StateObject var createJobDetails = numComboViewModel()
    @StateObject var setApiKeyInfo = setApiKey()
    
    var body: some View{
        
      NavigationView{
        ZStack{
            VStack{
                Spacer()
                
                HStack{
                    Text("Welcome")
                        .italic()
                    
                    Text(signOutOption.userInfo)
                        .italic()
                }
                
                ZStack{
                    Text("MENU")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .offset(x: 1.5, y: 2)
                    
                    Text("MENU")
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.trailing)
                        .padding()
                
                }
                
                NavigationLink(destination: ApiView(setApi: setApiKeyInfo), label: {
                    Text("API")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        .accessibilityIdentifier("API")
                })
                
                
                NavigationLink(destination: JobDetailsView(details: details), label: {
                            Text("Job Details")
                                .bold()
                                .frame(width: 300, height: 50)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(15)
                                .accessibilityIdentifier("JobDetails")
                })
                    
                NavigationLink(destination: createJob(viewModel: createJobDetails), label: {
                    Text("Create Job")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        .accessibilityIdentifier("CreateJob")
                })
                
                NavigationLink(destination: AddLockView(viewModel: addLockDetails, details: details), label: {
                    Text("Add Lock")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        .accessibilityIdentifier("AddLock")
                })

                
                NavigationLink(destination: SaveView(jobDetails: details, addLockDetails: addLockDetails, createJobDetails: createJobDetails, apiKeyInfo: setApiKeyInfo, finalInfo: allInfo), label: {
                    Text("Save Information")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        .accessibilityIdentifier("SaveInfo")
                })
                
                Spacer()
                
                Button("Sign Out", action:{
                    signOutOption.signOut()
                })
                    .foregroundColor(.black)
                    .accessibilityIdentifier("SignOut")
                
            }.navigationBarTitle("MENU")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack{
                            Text("LOCK THAT DOWN")
                                .bold()
                                .italic()
                                .padding()
                                
                            Image("Logo")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                                .padding()
                                .offset(x: -30, y: 0)
                                
                        }
                        .offset(x: 20,y: 0)
                    }
                }
                .offset(x: 0, y: -50.0)
    
        }.background(Image("Background")
            .resizable()
            .scaledToFill()
            .clipped()
            .opacity(0.40))
        .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

/*
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
*/
