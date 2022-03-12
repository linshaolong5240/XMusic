//
//  XMLoginState.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import ComposableArchitecture
import NeteaseCloudMusicAPI

public struct XMLoginState: Equatable {
    public var alert: AlertState<XMLoginAction>?
    public var email: String = "linshaolong5240@163.com"
    public var password: String = "LOST74123"
    public var loginStatus: Bool = false
    public var isLoginRequesting: Bool = false
    public var isLoginRefreshRequesting: Bool = true
    @CombineUserStorge(key: .loginUser, container: .group)
    public var loginUser: NCMLoginAction.Response? = nil
    public init() {}
}

public enum XMLoginAction: Equatable {
    case emailChanged(String)
    case passwordChanged(String)
    case loginSuccess
    case loginRequest
    case loginResponse(Result<NCMLoginAction.Response, XMError>)
    case loginRefreshRequest
    case loginRefreshRespone(Result<NCMLoginRefreshAction.Response, XMError>)
}

public struct XMLoginEnvironment {
    public var client: NeteaseCloudMusicAPI
    public var mainQueue: AnySchedulerOf<DispatchQueue>

    public init(client: NeteaseCloudMusicAPI, mainQueue: AnySchedulerOf<DispatchQueue> = .main) {
        self.client = client
        self.mainQueue = mainQueue
    }
}

public let xmLoginReducer = Reducer<XMLoginState, XMLoginAction, XMLoginEnvironment> {   state, action, environment in
    switch action {
    case let .emailChanged(email):
        state.email = email
        return .none
    case let .passwordChanged(password):
        state.password = password
        return .none
    case .loginSuccess:
        return .none
    case .loginRequest:
        state .isLoginRequesting = true
        return environment.client.requestPublisher(action: NCMLoginAction(email: state.email, password: state.password, rememberLogin: true))
            .mapError({XMError.login($0.localizedDescription) })
            .catchToEffect(XMLoginAction.loginResponse)
    case let .loginResponse(result):
        switch result {
        case .success(let response):
            state.loginUser = response
            state.isLoginRequesting = false
            return .init(value: .loginSuccess)
        case .failure(let error):
            state.alert = .init(title: TextState(error.localizedDescription), message: nil, dismissButton: .default(TextState("OK"), action: nil))
            return .none
        }
    case .loginRefreshRequest:
        state.isLoginRefreshRequesting = true
        return environment.client.requestPublisher(action: NCMLoginRefreshAction())
            .mapError({XMError.login($0.localizedDescription) })
            .catchToEffect(XMLoginAction.loginRefreshRespone)
    case .loginRefreshRespone(let result):
        state.isLoginRefreshRequesting = false
        switch result {
        case .success(let response):
            state.loginStatus = response.isSuccess
            if response.isSuccess {
                return .init(value: .loginSuccess)
            } else {
                return .none
            }
        case .failure(let error):
            state.alert = .init(title: TextState(error.localizedDescription), message: nil, dismissButton: .default(TextState("OK"), action: nil))
            return .none
        }
    }
}
