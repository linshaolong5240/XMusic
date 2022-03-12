//
//  AppState.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import ComposableArchitecture
import NeteaseCloudMusicAPI

public enum AppState: Equatable {
//    public var launch = XMLaunchState()
//    public var login = XMLaunchState()
//    public var ncmHome = XMNCMHomeState()
//    case launch(XMLaunchState)
    case login(XMLoginState)
    case ncmHome(XMNCMHomeState)
    public init() {
        self = .login(.init())//.launch(.init())
    }
}

public enum AppAction: Equatable {
//    case launch(XMLaunchAction)
    case login(XMLoginAction)
    case ncmHome(XMNCMHomeAction)
}

public struct AppEnvironment {
    public var client: NeteaseCloudMusicAPI = .shared
    
    public init() {}
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
//    xmLaunchReducer.pullback(state: /AppState.launch, action: /AppAction.launch, environment: { XMLaunchEnvironment(client: $0.client) }),
    xmLoginReducer.pullback(state: /AppState.login, action: /AppAction.login, environment: { XMLoginEnvironment(client: $0.client) }),
    xmNCMHomeReducer.pullback(state: /AppState.ncmHome, action: /AppAction.ncmHome, environment: { XMNCMHomeEnvironment(client: $0.client) }),
    Reducer { state, action, environment in
    switch action {
//    case .launch(.LaunchRefreshRespone(let result)):
//        switch result {
//        case .success(let response):
//            if response.isSuccess {
//                state = .ncmHome(XMNCMHomeState())
//            } else {
//                state = .login(.init())
//            }
//            return .none
//        case .failure:
//            state = .login(XMLoginState())
//        }
//        return .none
//    case .launch(_):
//        state = .login(.init())
//        return .none
    case .login(.loginSuccess):
        state = .ncmHome(XMNCMHomeState())
        return .none
    case .login(_):
        return .none
    case .ncmHome:
        return .none
    }
})
    .debug()
