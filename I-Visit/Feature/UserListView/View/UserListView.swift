//
//  UserListView.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct UserListView :View {
    
    @ObservedObject private var aUserListModel = UserListViewModel()
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isLoading = false

    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing:20), count:2)
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
                    .ignoresSafeArea(.all)
                VStack{
                    ScrollView(.vertical,showsIndicators: true){
                        VStack{
                            LazyVGrid(columns: columns,spacing:15)  {
                                ForEach(self.aUserListModel.UserListData ?? [] , id: \.self) { data in
                                    NavigationLink {
                                        UserDetailView(userData: data)
                                    }label:{
                                        UserCollectinCell(userList: data)
                                    }
                                    .onAppear {
                                        if data == self.aUserListModel.UserListData?.last {
                                            self.isLoading = true
                                            self.aUserListModel.getListOfUsers()
                                        }
                                    }
                                }
                            }
                        }
                        .padding([.horizontal])
                    }
                }
                if isLoading {
                    LoaderView(isLoading: $isLoading)
                }
            }
            .padding(.top)
            .background(.pink.opacity(0.8))
            
            .onReceive(aUserListModel.$UserListData) { userData in
                isLoading = false
            }
            
            .onReceive(aUserListModel.$errorMessage) { errorMessage in
                if let message = errorMessage {
                    isLoading = false
                    showAlert = true
                    alertMessage = message
                }
            }
            
            .showAlert(title: "", message: alertMessage, isPresented:$showAlert)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                DispatchQueue.main.async {
                    if aUserListModel.UserListData == nil || aUserListModel.UserListData?.isEmpty == true {
                        self.isLoading = true
                        self.aUserListModel.getListOfUsers()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct UserCollectinCell:View{
    
    var userList:UserList?
    let eachItemWidth = (screen.width - 40) / 2
    
    var body: some View{
        VStack{
            Color.white
            VStack(spacing:15){
                VStack{
                    WebImage(url: URL(string:userList?.picture  ?? ""))
                        .resizable()
                        .indicator(.activity(style: .circular))
                        .transition(.fade(duration: 0.5))
                        .cornerRadius(10)
                        .frame(height:eachItemWidth)
                }
                
                Text("\(userList?.firstName ?? "")" + " \(userList?.lastName ?? "")")
                    .font(.system(size:17,weight:.medium))
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            .padding()
        }
        .frame(width:eachItemWidth ,height: eachItemWidth * 1.3)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    UserListView()
}
