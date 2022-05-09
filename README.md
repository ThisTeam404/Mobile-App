# LockThatDown - Mobile Component
<img width="400" height="400" src="https://github.com/ThisTeam404/WebPart/blob/main/client/src/OfficialLogo.PNG" />

## Project Structure
This project is custom software made for The Smiling Locksmith®.
The project is split into 2 main components: the phone app and the web application
The phone app and web application are separated into separate repositories.

This is the link to the phone app repository: https://github.com/ThisTeam404/Mobile-App</br>
This is the link to the web application repository: https://github.com/ThisTeam404/WebPart</br>

# Project Description
The goal of this project is to have an app that generates key pins for door locks.
This app will be used by a locksmith who currently has to manually come up with
different key pins each time he works on a job.

This respository is for the iPhone app that will generate key pins for the door locks.
Each time the locksmith works on a lock he'll generate the key pins on the iphone and 
save it on our database. He can retrieve the key pins in the future by looking it up 
from the database using the website interface.

# Installation Guide

Step 1) Install Xcode (version 13.3.1 or later) on a macOS environment from the App Store </br>

Step 2) Clone this code repository to any location on the system </br>

Step 3) One way to clone the repository is using GitHub Desktop </br>
  * After installing GitHub Desktop and going to the the main page, go to the upper right and press Current Repository </br>
          
  * Press Add, then press Clone Repository. Go to URL </br>
          
  * Type the URL (the URL is from Code -> HTTPS. Copy the URL) in the "URL or username/repository" textfield </br>
          
  * Press clone </br>
  
Step 4) Begin a new app project in XCode </br>

Step 5) Choose any project name and choose a team if you would like to deploy in the future </br>

Step 6) In Xcode right click the project folder (normally on the left side-bar) and choose "Add New Files". Choose the .swift files cloned from this repo </br>

Step 7) Using Swift Package Manager, add Firebase Authentication SDK and Google Sign In SDK for user authentication </br>
  Those packages can be found at: </br>
  * Firebase -- https://github.com/firebase/firebase-ios-sdk </br>
    
  * GoogleSignIn iOS --  https://github.com/google/GoogleSignIn-iOS </br>

Note: Prerequisites to adding Firebase to our project: </br>
 - Xcode 13.3.1 or later </br>
 - iOS 10 or later </br>
 
When using Firebase be sure to build a project and connect it to your iOS project on https://firebase.google.com </br>
The bundle identifier of your Xcode project must be the same as the Apple bundle ID that shows on your Firebase project.</br>
When adding Firebase to your app, after you register your app, you will download the GoogleService-Info.plist and add it to your Xcode project files. </br>
This is needed to configure the identity provider we use -- Google Sign-In. </br>
On the Firebase console, go to the Authentication tab to enable the Google Sign-In method. </br>
The GoogleService-Info.plist file will contain a reversed client id, it is our client id that connects to the project and identifies itself to the authentication backend. </br>
It allows Firebase Auth to work properly with Google Sign-In. It must be copied and pasted under Info -> URL types -> URL Schemes in your Xcode project. </br>

Step 8) Choose the run icon on the top left of Xcode. The app should successfully build and run inside your chosen simulated environment (We normally choose iPhone 11 Pro) </br>

## Developers
Anthony Herrera</br>
Milford Gover</br>
Matthew Murata</br>
Kaily Estepa</br>
Sia Xiong</br>
Justin Moua</br>
Saba Taghibeik</br>
