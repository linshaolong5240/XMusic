//
//  XMError.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public enum XMError: Error, Equatable, LocalizedError {
    case login(String)
    
    public var errorDescription: String? {
        switch self {
        case let .login(description):
            return description
        }
    }
}
