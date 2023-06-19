//
//  RootView.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/04.
//

import SwiftUI

struct RootView: View {
    @State var showSignInView: Bool = false
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showSignInView: $showSignInView)
            }
        }
        // 뷰가 appear 할때, Firebase로부터, 이미 등록되어있는 유저 정보를 fetch 해와야 한다. => getAuthenticatedUser()
        .onAppear{
            let authUser = try?  AuthenticationManager.shared.getAutenticatedUser()
            // authUser가 없을 경우, SignInView가 나오도록
            self.showSignInView = authUser == nil 
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
