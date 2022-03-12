//
//  XMLaunchState.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import ComposableArchitecture
import NeteaseCloudMusicAPI

public struct XMLaunchState: Equatable {
    public var isOnAppeared: Bool = false
    public var isLoginRefreshRequesting: Bool = false
    public init() {}
}

public enum XMLaunchAction: Equatable {
    case onAppear
    case LaunchRefreshRequest
    case LaunchRefreshRespone(Result<NCMLoginRefreshAction.Response, XMError>)
}

public struct XMLaunchEnvironment {
    public var client: NeteaseCloudMusicAPI
    public var mainQueue: AnySchedulerOf<DispatchQueue>
    public init(client: NeteaseCloudMusicAPI, mainQueue: AnySchedulerOf<DispatchQueue> = .main) {
        self.client = client
        self.mainQueue = mainQueue
    }
}

public let xmLaunchReducer = Reducer<XMLaunchState, XMLaunchAction, XMLaunchEnvironment> {   state, action, environment in
    struct RequestID: Hashable {}

    switch action {
    case .onAppear:
        state.isOnAppeared = true
        return .none
    case .LaunchRefreshRequest:
        state.isLoginRefreshRequesting = true
        return environment.client.requestPublisher(action: NCMLoginRefreshAction())
            .mapError({XMError.login($0.localizedDescription) })
            .catchToEffect(XMLaunchAction.LaunchRefreshRespone)
            .cancellable(id: RequestID())
    case .LaunchRefreshRespone(_):
        state.isLoginRefreshRequesting = false
        return .none
    }
}
