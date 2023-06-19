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
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAutenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        } // guard문을 통해 error 거르기
        
        try await AuthenticationManager.shared.resetPassword(email: email)
        
    }
    
    func updatePassword() async throws {
        let password = "1234" // UI 만들기 귀찮아서 그냥 임의의 dummy 값으로 update 해주는 기능으로 구성
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        let email = "dummy@dummy.com"// UI 만들기 귀찮아서 그냥 임의의 dummy 값으로 update 해주는 기능으로 구성
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView : Bool
    // 뷰가 뷰모델을 속성으로 가진다.
    var body: some View {
        List{
            Button("Log out"){
                
                Task{
                    do{
                        try viewModel.signOut() // 로컬의 유저정보 signout => sign in 의 show를 true로 설정
                        showSignInView = true
                    } catch{
                        print(error)
                    }
                }
                
            }
            emailSection
        }
        .navigationTitle("Settings")
    }
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset Password"){
                
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print("Password Reset!")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update Password"){
                
                Task{
                    do{
                        try await viewModel.updatePassword()
                        print("Password Updated!")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update Email"){
                
                Task{
                    do{
                        try await viewModel.updateEmail()
                        print("Email Updated!")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Section")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}
