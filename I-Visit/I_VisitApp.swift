//
//  I_VisitApp.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 09/12/24.
//

import SwiftUI

@main
struct I_VisitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
