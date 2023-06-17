//
//  FirebasePracticeApp.swift
//  FirebasePractice
//
//  Created by 황지우2 on 2023/06/04.
//

import SwiftUI
import Firebase // 추가한 패키지인 Firebase를 import

@main
struct FirebasePracticeApp: App {
    init(){ // 앱의 진입점인 Struct에 initializer 추가
        FirebaseApp.configure()
        print("firebase configure 완료")
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}
