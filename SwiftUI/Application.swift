//
//  Application.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI

final class ApplicationUtility{
    
    static var rootViewController: UIViewController{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
