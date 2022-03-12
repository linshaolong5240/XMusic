//
//  RootView.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<AppState, AppAction>
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
    }
    
    var body: some View {
        NavigationView {
            SwitchStore(store) {
//                CaseLet(state: /AppState.launch, action: AppAction.launch) { store in
//                    NavigationView {
//                    XMLaunchView(store: store)
//                    }
//                    .navigationViewStyle(.stack)
//                }
                CaseLet(state: /AppState.login, action: AppAction.login) { store in
                    XMLoginView(store: store)
                }
                CaseLet(state: /AppState.ncmHome, action: AppAction.ncmHome) { store in
                    XMNCMHomeView(store: store)
                }
            }
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: .init(initialState: AppState(), reducer: appReducer, environment: AppEnvironment()))
    }
}
#endif
