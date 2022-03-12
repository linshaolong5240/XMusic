//
//  XMLaunchView.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct XMLaunchView: View {
    let store: Store<XMLaunchState, XMLaunchAction>
    
    public init(store: Store<XMLaunchState, XMLaunchAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store, removeDuplicates: ==) { viewStore in
            Image("LaunchScreen")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .onAppear {
                    if !viewStore.state.isOnAppeared {
                        viewStore.send(.onAppear)
                    }
                    print("Works as usual - only fired on appear, even when navigation back to this view as expected")
                }
                .onAppear {
                    print("Fired directly after onDisappear")
                }
                .onDisappear {
                    print("Fired on Disappear as expected")
                }
        }
    }
}

struct XMLauchView_Previews: PreviewProvider {
    static var previews: some View {
        XMLaunchView(store: .init(initialState: XMLaunchState(), reducer: xmLaunchReducer, environment: XMLaunchEnvironment(client: .shared)))
    }
}
