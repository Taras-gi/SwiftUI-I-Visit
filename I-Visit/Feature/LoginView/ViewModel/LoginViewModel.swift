//
//  LoginViewModel.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 09/12/24.
//

import SwiftUI

class LoginViewModel:ObservableObject {
    
    @Published var loginModel:LoginModel? = nil
    @Published var errorMessage:String?
    
    func loginAPi(email:String,password:String){
        
        let url = baseUrl + ApiType.login.rawValue
        let model = LoginRequestModel(email:email, password:password)
        guard let loginData = model.loginRequestData() else { return }
        self.errorMessage = nil
        
        APIManager.shared.callAPI(apiUrl:url, methodType: .post, modelData: loginData, token: "") {(response:Result<LoginModel,Error>) in
            switch response {
            case .success(let data):
                self.loginModel = data
                UserDataManager.shared.homeScreen = true
                print( self.loginModel as Any)
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = Constant.Alert.apiError
            }
        }
    }
    
    func validateEmail(email:String,password:String)-> (Bool,String?) {
        
        guard email.count > 0 else { return (false,Constant.Alert.emptyEmail)}
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if  emailPred.evaluate(with: email) {
            guard password.count > 0  else { return (false,Constant.Alert.emptyPassword)}
            return (true,nil)
        }else{
            return (false,Constant.Alert.invalidEmail)
        }
    }
}
