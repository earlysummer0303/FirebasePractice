//
//  SettingsView.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/17.
//

import SwiftUI

@MainActor
final class SettingsViewModel : ObservableObject  {
    
    // 로그아웃
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView : Bool
    // 뷰가 뷰모델을 속성으로 가진다.
    var body: some View {
        List{
            Button("log out"){
                
                Task{
                    do{
                        try viewModel.signOut() // 로컬의 유저정보 signout => sign in 의 show를 true로 설정
                        showSignInView = true
                    } catch{
                        print(error)
                    }
                }
                
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}
