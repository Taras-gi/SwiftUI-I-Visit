//
//  SplashView.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import Foundation
import SwiftUI



struct SplashView:View {
    
    @State private var designationView:AnyView?
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.clear
                    .ignoresSafeArea(.all)
                Image(Constant.Splash.splashIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:250,height: 250)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                    if let session = UserDataManager.shared.homeScreen, session {
                        designationView = AnyView(UserListView())
                    }else{
                        designationView = AnyView(LoginView())
                    }
                    self.isActive = true
                }
            }
            .background{
                NavigationLink(destination:designationView, isActive:$isActive) {
                    EmptyView()
                }
            }
        }
    }
}

