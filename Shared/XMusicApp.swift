//
//  XMusicApp.swift
//  Shared
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI

@main
struct XMusicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
