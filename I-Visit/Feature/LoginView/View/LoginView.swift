//
//  ContentView.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 09/12/24.
//

import SwiftUI
import CoreData

let screen = UIScreen.main.bounds

struct LoginView: View {
    
    private var aLoginViewModel = LoginViewModel()
    @State private var emailID:String = "eve.holt@reqres.in"
    @State private var password:String = "cityslicka"
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isLoading = false
    @State private var isLoginSuccessful = false // Track successful login
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.white
                    .ignoresSafeArea(.all)
                VStack(spacing:40){
                    VStack{
                        Text(Constant.Login.login)
                            .font(.system(size:35,weight:.semibold))
                            .foregroundColor(.black)
                    }
                    VStack(spacing:30){
                        LoginTextFieldView(placeholder:Constant.Login.enterEmail, text: $emailID,secure:false )
                        LoginTextFieldView(placeholder:Constant.Login.enterPassword , text: $password,secure:true )
                    }
                    Button {
                        let isValidated = self.aLoginViewModel.validateEmail(email: emailID, password: password)
                        if isValidated.0 {
                            self.isLoading = true
                            self.aLoginViewModel.loginAPi(email: emailID, password: password)
                        }else{
                            showAlert = true
                            alertMessage = isValidated.1 ?? ""
                        }
                    } label: {
                        Text(Constant.Login.go)
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width:(screen.width * 0.5),height: 43)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                if isLoading {
                    LoaderView(isLoading: $isLoading)
                }
            }
            .padding([.top,.bottom])
            
            .onReceive(aLoginViewModel.$loginModel) { loginModel in
                if loginModel != nil {
                    isLoading = false
                    isLoginSuccessful = true
                }
            }
            
            .onReceive(aLoginViewModel.$errorMessage) { errorMessage in
                if let message = errorMessage {
                    isLoading = false
                    showAlert = true
                    alertMessage = message
                }
            }
            .showAlert(title: "", message: alertMessage, isPresented:$showAlert)
            .background{
                NavigationLink(destination: UserListView(), isActive: $isLoginSuccessful) {
                    EmptyView()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


struct LoginTextFieldView:View{
    
    var placeholder:String = ""
    @Binding var text:String
    var secure:Bool = false
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack {
            if secure {
                HStack{
                    Group {
                        if isPasswordVisible {
                            TextField(placeholder, text: $text)
                        } else {
                            SecureField(placeholder, text: $text)
                        }
                    }
                    .textFieldStyle(.plain)
                    .font(.system(size: 16))
                    HStack{
                        Button(action: {
                            self.isPasswordVisible.toggle()
                        }) {
                            Image(systemName:self.isPasswordVisible ? Constant.Login.hidePassword : Constant.Login.showPassword)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                }
            }else{
                TextField(placeholder, text:$text)
                    .textFieldStyle(.plain)
                    .font(.system(size: 16))
            }
        }
        .padding(.leading,15)
        .frame(width:screen.width * 0.85,height: 45)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.black), lineWidth: 1)
        )
    }
}

#Preview {
    LoginView()
}
