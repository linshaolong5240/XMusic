//
//  UserStorgeHelper.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
#if canImport(Combine)
import Combine
#endif
#if canImport(RxRelay)
import RxRelay
#endif

extension UserDefaults {
    public static let group: UserDefaults = UserDefaults(suiteName: "group.com.teenloong.Qin")!
}

public struct UserStorgeKey: RawRepresentable, Equatable {
    public typealias RawValue = String
    public var rawValue: RawValue
    
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static let username = UserStorgeKey(rawValue: "username")!
    public static let firstLaunched = UserStorgeKey(rawValue: "firstLaunched")!
    public static let likedSongsId = UserStorgeKey(rawValue: "likedSongsId")!
    public static let loginUser = UserStorgeKey(rawValue: "loginUser")!
    public static let playerCoverShape = UserStorgeKey(rawValue: "playerCoverShape")!
    public static let playerPlayingIndex = UserStorgeKey(rawValue: "playerPlayingIndex")!
    public static let playerPlayingMode = UserStorgeKey(rawValue: "playerPlayingMode")!
    public static let playerPlayingSong = UserStorgeKey(rawValue: "playerPlayingSong")!
    public static let playerPlaylist = UserStorgeKey(rawValue: "playerPlaylist")!
    public static let playerSong = UserStorgeKey(rawValue: "playerSong")!
}

@available(iOS 13.0, *)
@propertyWrapper
public struct CombineUserStorge<T: Codable & Equatable>: Equatable {
    public static func == (lhs: CombineUserStorge<T>, rhs: CombineUserStorge<T>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    private let container: UserDefaults
    private let key: String
    private let defaultValue: T
#if canImport(Combine)
    public var projectedValue: CurrentValueSubject<T, Never>
#endif
    public var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key) else { return defaultValue }
            return (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
        }
        set {
            container.set(try? JSONEncoder().encode(newValue) , forKey: key)
            container.synchronize()
#if canImport(Combine)
            projectedValue.send(newValue)
#endif
        }
    }
    
    init(wrappedValue: T, key: UserStorgeKey, container: UserDefaults) {
        self.container = container
        self.key = key.rawValue
        self.defaultValue = wrappedValue
#if canImport(Combine)
        var savedValue: T = wrappedValue
        if let data = container.data(forKey: key.rawValue) {
            savedValue = (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
        }
        projectedValue =  .init(savedValue)
#endif
    }
}

@propertyWrapper
public struct RxUserStorge<T: Codable & Equatable> {
    struct Wrapper<T> : Codable where T : Codable {//Ios13以下 JSONEncoder 不支持JSON fragment转Data，需要一个容器兼容
        let wrapped : T
    }
    private let container: UserDefaults
    private let key: String
    private let defaultValue: T
#if canImport(RxRelay)
public var projectedValue: BehaviorRelay<T>
#endif
    public var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key) else { return defaultValue }
            return (try? JSONDecoder().decode(Wrapper<T>.self, from: data))?.wrapped ?? defaultValue
        }
        set {
            container.set(try? JSONEncoder().encode(Wrapper(wrapped: newValue)) , forKey: key)
            container.synchronize()
#if canImport(RxRelay)
            projectedValue.accept(newValue)
#endif
        }
    }

    init(wrappedValue: T, key: UserStorgeKey, container: UserDefaults) {
        self.container = container
        self.key = key.rawValue
        self.defaultValue = wrappedValue
#if canImport(RxRelay)
        var savedValue: T = wrappedValue
        if let data = container.data(forKey: key.rawValue) {
            savedValue = (try? JSONDecoder().decode(Wrapper<T>.self, from: data))?.wrapped ?? wrappedValue
        }
        self.projectedValue = BehaviorRelay(value: savedValue)
#endif
    }
}
