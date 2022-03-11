//
//  LoginView.swift
//  XMusic (iOS)
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import NeumorphismSwiftUI

struct LoginView: View {
    @EnvironmentObject var store: XMStore
    private var settings: XMAppState.Settings { store.appState.settings }

    @State  private var email: String = ""
    @State  private var password: String = ""
    
    var body: some View {
        ZStack {
            QinBackgroundView()
            VStack(spacing: 20.0) {
                HStack {
                    QinBackwardButton()
                    Spacer()
                }
                .overlay(
                    QinNavigationBarTitleView("登录")
                )
                TextField("email", text: $email)
                    .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "envelope").foregroundColor(.mainText)))
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                SecureField("password", text: $password)
                    .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "key").foregroundColor(.mainText)))
                    .autocapitalization(.none)
                    .keyboardType(.asciiCapable)
                Button(action: {
                    self.store.dispatch(.loginRequest(email: self.email, password: self.password))
                }) {
                    Text("登录")
                        .padding()
                }
                .buttonStyle(NEUDefaultButtonStyle(shape: Capsule()))
                if store.appState.settings.loginRequesting {
                    Text("正在登录...")
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(XMStore.shared)
            .preferredColorScheme(.light)
        LoginView()
            .environmentObject(XMStore.shared)
            .preferredColorScheme(.dark)

    }
}
#endif
