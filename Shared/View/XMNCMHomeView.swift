//
//  XMNCMHomeView.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct XMNCMHomeView: View {
    let store: Store<XMNCMHomeState, XMNCMHomeAction>
    
    enum ViewAction {
        case NCMHomeButtonTapped
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                QinBackgroundView()
                VStack {
                    QinCoverView(viewStore.state.loginUser?.profile.avatarUrl, style: QinCoverStyle(size: .medium, shape: .rectangle))
                    if let nicname = viewStore.state.loginUser?.profile.nickname {
                        Text(nicname)
                    }
                }
            }
            .foregroundColor(.mainText)
         }
    }
}

#if DEBUG
struct XMNCMHomeView_Previews: PreviewProvider {
    static var previews: some View {
        XMNCMHomeView(store: .init(initialState: XMNCMHomeState(), reducer: xmNCMHomeReducer, environment: XMNCMHomeEnvironment()))
    }
}
#endif

//extension XMNCMHomeAction {
//    init(action: XMNCMHomeView.ViewAction) {
//        switch action {
//        case .NCMHomeButtonTapped:
//            self = .NCMHomeButtonTapped
//        }
//    }
//}
