//
//  UserDetailView.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailView: View {
    
    var userData:UserList?
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isLoading = false
    @ObservedObject var aUserDetailViewModel = UserDetailViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.clear
                    .ignoresSafeArea(.all)
                VStack{
                    if self.aUserDetailViewModel.UserDetails != nil {
                        VStack{
                            WebImage(url: URL(string:self.aUserDetailViewModel.UserDetails?.picture  ?? ""))
                                .resizable()
                                .indicator(.activity(style: .circular))
                                .transition(.fade(duration: 0.5))
                                .cornerRadius(10)
                                .frame(width:200,height:200)
                        }
                        HStack{
                            VStack(spacing:15){
                                HStack{
                                    UserDetailTextView(isHeader:true ,text:Constant.UserDetail.name)
                                        .fixedSize(horizontal: true, vertical: false)
                                    
                                    Spacer()
                                    
                                    let name = self.createName()
                                    UserDetailTextView(isHeader:true ,text:name)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                VStack(spacing:3){
                                    HStack{
                                        UserDetailTextView(isHeader:true ,text:Constant.UserDetail.gender)
                                            .fixedSize(horizontal: true, vertical: false)
                                        
                                        Spacer()
                                        
                                        UserDetailTextView(isHeader:false ,text:self.aUserDetailViewModel.UserDetails?.gender ?? "")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                        
                                    }
                                    HStack{
                                        let birthDate = self.createDateofEvent(isoDate: self.aUserDetailViewModel.UserDetails?.dateOfBirth ?? "")
                                        
                                        UserDetailTextView(isHeader:true ,text:Constant.UserDetail.dob)
                                            .fixedSize(horizontal: true, vertical: false)
                                        
                                        Spacer()
                                        
                                        UserDetailTextView(isHeader:false ,text: birthDate)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                    HStack{
                                        let registerDate = self.createDateofEvent(isoDate: self.aUserDetailViewModel.UserDetails?.registerDate ?? "")
                                        UserDetailTextView(isHeader:true ,text: Constant.UserDetail.registerDate)
                                            .fixedSize(horizontal: true, vertical: false)
                                        
                                        Spacer()
                                        
                                        UserDetailTextView(isHeader:false ,text:registerDate)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                VStack(spacing:3){
                                    HStack{
                                        UserDetailTextView(isHeader:true ,text:Constant.UserDetail.email )
                                            .fixedSize(horizontal: true, vertical: false)
                                        
                                        Spacer()
                                        
                                        UserDetailTextView(isHeader:false ,text:self.aUserDetailViewModel.UserDetails?.email ?? "")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                        
                                    }
                                    HStack{
                                        UserDetailTextView(isHeader:true ,text:Constant.UserDetail.phone )
                                            .fixedSize(horizontal: true, vertical: false)
                                        
                                        Spacer()
                                        
                                        UserDetailTextView(isHeader:false ,text:self.aUserDetailViewModel.UserDetails?.phone ?? "")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                VStack(spacing:3){
                                    HStack{
                                        UserDetailTextView(isHeader:true ,text:Constant.UserDetail.address )
                                    }
                                    HStack{
                                        let address = self.createAddress()
                                        UserDetailTextView(isHeader:false ,text:address,lineLimit: 2)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    Spacer()
                }
                if isLoading {
                    LoaderView(isLoading: $isLoading)
                }
            }
            .padding(.top)
            
            .onReceive(aUserDetailViewModel.$UserDetails) { userData in
                isLoading = false
            }
            
            .onReceive(aUserDetailViewModel.$errorMessage) { errorMessage in
                if let message = errorMessage {
                    isLoading = false
                    showAlert = true
                    alertMessage = message
                }
            }
            .showAlert(title: "", message: alertMessage, isPresented:$showAlert)
            
            .onAppear {
                self.isLoading = true
                print(userData?.id ?? "")
                self.aUserDetailViewModel.getListOfUsers(userID:userData?.id ?? "")
            }
        }
    }
    
    func createAddress() -> String{
        let location:Location? = self.aUserDetailViewModel.UserDetails?.location
        let address = "\(location?.street ?? ""), " + "\(location?.city ?? ""), " + "\(location?.state ?? ""), " +  "\(location?.country ?? "")"
        return address
    }
    
    func createName() -> String{
        let userDetail:UserDetailModel? = self.aUserDetailViewModel.UserDetails
        let name = "\(userDetail?.title ?? "")" + " \(userDetail?.firstName ?? "")" + " \(userDetail?.lastName ?? "")"
        return name
    }
    
    func createDateofEvent(isoDate:String) -> String{
        if let formattedDate = isoDate.toDateFormat(outputFormat: "MMMM dd yyyy") {
            print(formattedDate)
            return formattedDate
        } else {
            return "-"
        }
    }
}

struct UserDetailTextView:View{
    
    var isHeader:Bool = true
    var text:String = ""
    var lineLimit:Int = 1
    
    var body : some View {
        Text(text)
            .foregroundColor(.black)
            .font(.system(size:isHeader ? 16 : 14.5,weight:isHeader ? .semibold : .medium))
            .lineLimit(lineLimit)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    UserDetailView()
}
