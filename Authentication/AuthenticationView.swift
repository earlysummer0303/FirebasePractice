//
//  AuthenticationView.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/04.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSignInView : Bool
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.blue))
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Sign In")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AuthenticationView(showSignInView : .constant(true))
        }
    }
}
