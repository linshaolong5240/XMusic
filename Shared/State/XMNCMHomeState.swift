//
//  XMNCMHomeState.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import ComposableArchitecture
import NeteaseCloudMusicAPI
import SwiftUI

public struct XMNCMHomeState: Equatable {
    @CombineUserStorge(key: .username, container: .group)
    public var username: String = ""
    public init() {}
}

public enum XMNCMHomeAction: Equatable {
    case NCMHomeButtonTapped
}

public struct XMNCMHomeEnvironment {
    public var client: NeteaseCloudMusicAPI
    
    public init(client: NeteaseCloudMusicAPI = .shared) {
        self.client = client
    }
}

public let xmNCMHomeReducer = Reducer<XMNCMHomeState, XMNCMHomeAction, XMNCMHomeEnvironment> {   state, action, environment in
    switch action {
    case .NCMHomeButtonTapped:
        return .none
    }
}
