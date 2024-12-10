//
//  UserDetailViewModel.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import SwiftUI

class UserDetailViewModel:ObservableObject {
    
    @Published var UserDetails:UserDetailModel?
    @Published var errorMessage:String?
    
    func getListOfUsers(userID:String){
        
        let url = baseUrl1 + ApiType.userDetails.rawValue + userID
        print(url)
        
        APIManager.shared.callAPI(apiUrl:url, methodType: .get, modelData: nil, token: "") {(response:Result<UserDetailModel,Error>) in
            switch response {
            case .success(let data):
                self.UserDetails = data
                print(self.UserDetails as Any)
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = Constant.Alert.apiError
            }
        }
    }
}
