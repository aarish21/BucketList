//
//  ContentView.swift
//  BucketList
//
//  Created by Aarish on 25/04/22.
//

import SwiftUI
import LocalAuthentication



struct ContentView: View {
    @State private var isUnlocked = false
    var body: some View {
        VStack{
            if isUnlocked{
                Text("unlocked")
            }else{
                Text("locked")
            }
        }
        .onAppear(perform: authenticate)
    
      
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
            isUnlocked = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
