//
//  JobDetailsVM.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 4/14/22.
//

import Foundation
import SwiftUI

//accessible to job details and add lock

class JobDetails: ObservableObject{
   
    @Published var jobCost = ""
    @Published var jobAddress = ""
    @Published var jobNotes = ""
    @Published var numkeys = ""
 
}

