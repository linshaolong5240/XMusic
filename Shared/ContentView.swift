//
//  ContentView.swift
//  Shared
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        #if os(macOS)
        SideBarNavigationView()
            .frame(width: 800, height: 600)
        #else
        HomeView()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
