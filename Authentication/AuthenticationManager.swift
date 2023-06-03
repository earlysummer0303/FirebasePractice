//
//  AuthenticationManager.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/04.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
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
    
    // create user
    // Auth의 createUser함수를 더 간단하게 사용하기 위한 custom function
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        // authDataResult
            // createUser 함수를 통해 입력한 이메일, pw 값에 따른 유저 생성
            // authDataResult.user => 생성된 유저를 User타입으로 반환.
        
        // authDataResult.user로 AuthDataModel 생성
        let result = AuthDataResultModel(user: authDataResult.user)
        
        return result
    }
}
