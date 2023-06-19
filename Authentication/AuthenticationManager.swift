//
//  AuthenticationManager.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/04.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel { //Firebase에 저장될 데이터 모델
    let uid: String
    let email: String?
    let photoUrl : String?
    
    init(user : User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager() // 싱글톤 패턴이라는데 아직 모르겠는 내용
    private init(){
        
    }
    
    // create user (Signup)
    // 이 프로젝트에서는 동일한 계정을 처음으로 입력했을때 Signup 으로 간주.
    // Auth의 createUser함수를 더 간단하게 사용하기 위한 custom function
    @discardableResult // warning 메세지 제거
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        // authDataResult
            // createUser 함수를 통해 입력한 이메일, pw 값에 따른 유저 생성
            // authDataResult.user => 생성된 유저를 User타입으로 반환.
        
        // authDataResult.user로 AuthDataModel 생성
        let result = AuthDataResultModel(user: authDataResult.user)
        
        return result
    }
    
    //signIn User - 로그인
    // 이 프로젝트에서는 동일한 계정을 두번째 이상으로 입력했을때 Sign in으로 간주.
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        
        return result
    }
    
    // getAutenticatedUser => 이미 저장된 유저정보를 가지고 오는것.
    
    func getAutenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else { // Optional Binding
            // 유저 정보를 받아 올 수 없다면.
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    // getAutenticatedUser 함수는 async 키워드가 없다 => 서버에 접근하는 것이 아닌 로컬 정보를 가져오는 것!
    // 이 유저가 autenticated 되었는지 안되었는지 확인
    // 한번 authenticated 가 되면, local의 sdk에 저장되게 됨.
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    //update
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else { // Optional Binding
            // 유저 정보를 받아 올 수 없다면.
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else { // Optional Binding
            // 유저 정보를 받아 올 수 없다면.
            throw URLError(.badServerResponse)
        }
        try await user.updateEmail(to: email)
    }
    
}
