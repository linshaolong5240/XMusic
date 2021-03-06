//
//  SettingView.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 teenloong. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: XMStore
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: ThemeSelectView()) {
                    Text("主题")
                }
            }
        }
    }
}
struct ThemeSelectView: View {
    @EnvironmentObject var store: XMStore
    private var settings: XMAppState.Settings {store.appState.settings}
    
    var body: some View {
        VStack {
            Form {
                Section {
                    ForEach(XMAppState.Settings.Theme.allCases, id: \.self) { item in
                        Button(action: {
                        }) {
                            HStack {
                                Text("\(String(describing: item))")
                                Spacer()
                                if item == settings.theme {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView().environmentObject(XMStore())
        }
    }
}
#endif
