//
//  LoginView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 04/11/22.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State private var isUnlocked = false
    @State private var failedAuth = ""
    @AppStorage("needPrivacy") var needPrivacy: Bool = false
    
    var body: some View {
        if isUnlocked || !needPrivacy {
            ContentView()
        } else {
            VStack {
                Text("Hola \nAmigos")
                    .font(Font.system(size: 64, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .blue, .mint, .teal],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding()
                LottieView(lottieFile: "95530-password")
                    .frame(width: 500, height: 200)
                    .padding(50)
                Button(action: authenticate) {
                    HStack {
                        Image(systemName: "lock.open")
                        Text("Login with biometrics")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.black))
                    .shadow(color: .gray, radius: 2, x: -3, y: 5)
                }
                
                Text(failedAuth)
                    .padding()
                    .opacity(failedAuth.isEmpty ? 0.0 : 1.0)
            }
        }
    }
    
    private func authenticate() {
        var error: NSError?
        let laContext = LAContext()
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Need access to authenticate"
            
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                        failedAuth = ""
                    } else {
                        print(error?.localizedDescription ?? "error")
                        failedAuth = error?.localizedDescription ?? "error"
                    }
                }
            }
        } else {
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
