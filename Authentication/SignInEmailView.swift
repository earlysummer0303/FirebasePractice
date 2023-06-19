//
//  SignUpWithEmailView.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/04.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("이메일 혹은 패스워드가 입력되지 않았습니다.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password)
 
    }
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("이메일 혹은 패스워드가 입력되지 않았습니다.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
 
    }
}

struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView : Bool
    
    var body: some View {
        VStack{
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            SecureField("Password", text: $viewModel.password) // 입력값이 가려지는 Textfield
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            Button {
                Task {
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return // 성공시 return => 다음 do로 넘어가지 않는다.
                    } catch {
                        print(error)
                    }
                    do { // if signup fails => sign in
                        try await viewModel.signIn()
                        showSignInView = false
                        print("sign in success")
                        return
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.blue))
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInEmailView(showSignInView: .constant(true))
        }
    }
}
