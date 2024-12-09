//
//  UserViewModel.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import SwiftUI

class UserListViewModel:ObservableObject {
    
    @Published var UserListData:[UserList]? = []
    @Published var errorMessage:String?
    var pageNo:Int = 0
    var isPaginationEnabled:Bool = true
    let limit:Int = 10
    
    func getListOfUsers(){
        guard self.isPaginationEnabled else {
            self.UserListData = self.UserListData
            return
        }
        pageNo += 1
        let url = baseUrl1 + ApiType.userList.rawValue + "limit=\(limit)&page=\(pageNo)"
        print(url)
        APIManager.shared.callAPI(apiUrl:url, methodType: .get, modelData: nil, token: "") {(response:Result<UserListModel,Error>) in
            switch response {
            case .success(let data):
                self.isPaginationEnabled = data.data?.count == self.limit
                DispatchQueue.main.async {
                    self.UserListData?.append(contentsOf: data.data ?? [])
                    print( self.UserListData as Any)
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorMessage = Constant.Alert.apiError
                }
            }
        }
    }
}
