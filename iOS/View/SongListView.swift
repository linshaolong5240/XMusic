//
//  SongListView.swift
//  XMusic (iOS)
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import NeumorphismSwiftUI

struct SongListView: View {
    @EnvironmentObject private var store: XMStore
    @State private var showPlayingNow: Bool = false
    @State private var showLike: Bool = false
    
    let songs: [Song]
    
    var body: some View {
        VStack {
            NavigationLink(destination: PlayerView(), isActive: $showPlayingNow, label: {EmptyView()})
                .navigationViewStyle(StackNavigationViewStyle())
            HStack {
                Button(action: {
                    if showLike {
                        let likeIds = XMStore.shared.appState.playlist.songlikedIds
                        XMStore.shared.dispatch(.PlayerPlaySongs(songs: songs.map(QinSong.init)
                                                                .filter({ likeIds.contains($0.id) })))
                    }else {
                        XMStore.shared.dispatch(.PlayerPlaySongs(songs: songs.map(QinSong.init)))
                    }
                    XMStore.shared.dispatch(.playerPlayBy(index: 0))
                }) {
                    Text(showLike ? "播放喜欢" : "播放全部")
                        .fontWeight(.bold)
                }
                Spacer()
                Text("喜欢")
                    .fontWeight(.bold)
                    .foregroundColor(.secondTextColor)
                Toggle("", isOn: $showLike)
                    .toggleStyle(NEUDefaultToggleStyle())
                    .fixedSize()
                    .accentColor(.orange)
            }
            .padding(.horizontal)
            ScrollView {
                LazyVStack {
                    ForEach(songs) { item in
                        if !showLike || store.appState.playlist.songlikedIds.contains(Int(item.id)) {
                            QinSongRowView(viewModel: .init(item.asQinSong()))
                                .padding(.horizontal)
                                .onTapGesture {
                                    if Int(item.id) == XMStore.shared.appState.playing.song?.id {
                                        showPlayingNow.toggle()
                                    }
                                }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}
