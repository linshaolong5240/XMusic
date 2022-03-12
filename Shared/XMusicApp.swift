//
//  XMusicApp.swift
//  Shared
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 teenloong. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@main
struct XMusicApp: App {
    @Environment(\.scenePhase) private var scenePhase
    #if canImport(UIKit)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate
    #endif
//    @StateObject var store = XMStore.shared
//    @StateObject var player = Player.shared
    let context = DataManager.shared.context()
    
    let store = Store(
      initialState: AppState(),
      reducer: appReducer,
      environment: AppEnvironment()
    )

//    let persistenceController = PersistenceController.shared
    init() {
        #if DEBUG
//        NCM.debug = false
        #endif
    }
    var body: some Scene {
        WindowGroup {
            RootView(store: store)
//            ContentView()
//                .onAppear {
//                    store.dispatch(.loginRefreshRequest)
//                }
//                .environmentObject(store)
//                .environmentObject(player)
                .environment(\.managedObjectContext, context)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .onChange(of: scenePhase) { newValue in
//                    switch newValue {
//                    case .active:
//                        break
//                    case .background:
//                        break
//                    case .inactive:
//                        break
//                    @unknown default:
//                        break
//                    }
//                }
        }
    }
}

#if canImport(UIKit)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AudioSessionManager.shared.configuration()
        return true
    }
}
#endif
