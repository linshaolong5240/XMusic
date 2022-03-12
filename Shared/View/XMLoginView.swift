//
//  XMLoginView.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import NeumorphismSwiftUI
import NeteaseCloudMusicAPI

public struct XMLoginView: View {
    let store: Store<XMLoginState, XMLoginAction>
    
    public init(store: Store<XMLoginState, XMLoginAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                QinBackgroundView()
                VStack(spacing: 20.0) {
                    QinNavigationBarTitleView("Login")
                    TextField("Email", text: viewStore.binding(get: \.email, send: XMLoginAction.emailChanged))
                        .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "envelope").foregroundColor(.mainText)))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: viewStore.binding(get: \.password, send: XMLoginAction.passwordChanged))
                        .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "key").foregroundColor(.mainText)))
                        .autocapitalization(.none)
                        .keyboardType(.asciiCapable)
                    Button(action: {
                        viewStore.send(.loginRequest)
                    }) {
                        Text("登录")
                            .padding()
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: Capsule()))
                    //                if store.appState.settings.loginRequesting {
                    //                    Text("正在登录...")
                    //                }
                    Spacer()
                }
                .padding(.horizontal)
                if viewStore.state.isLoginRefreshRequesting {
                    Image("LaunchScreen")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    viewStore.send(.loginRefreshRequest)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#if DEBUG
struct XMLoginView_Previews: PreviewProvider {
    static var previews: some View {
        XMLoginView(store: .init(initialState: XMLoginState(), reducer: xmLoginReducer, environment: XMLoginEnvironment(client: .shared)))
    }
}
#endif
