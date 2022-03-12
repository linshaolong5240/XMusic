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
    
    struct ViewState: Equatable {
        public var username: String
        public init(state: XMNCMHomeState) {
            self.username = state.username
        }
    }
    
    enum ViewAction {
        case NCMHomeButtonTapped
    }

    var body: some View {
        WithViewStore(store.scope(state: ViewState.init, action: XMNCMHomeAction.init)) { viewStore in
            Text(viewStore.username)
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

extension XMNCMHomeAction {
    init(action: XMNCMHomeView.ViewAction) {
        switch action {
        case .NCMHomeButtonTapped:
            self = .NCMHomeButtonTapped
        }
    }
}
