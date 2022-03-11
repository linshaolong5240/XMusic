//
//  PlaylistManageView.swift
//  XMusic (iOS)
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import NeumorphismSwiftUI
import NeteaseCloudMusicAPI

struct PlaylistManageView: View {
    let playlist = Store.shared.appState.playlist.userPlaylist
    @State private var editMode: EditMode = .active
    @Binding var showSheet: Bool
    @State private var ids = [Int]()
    @State private var deleteId: Int64 = 0
    @State private var isDeleted: Bool = false
    @State private var isMoved: Bool = false
    
    var body: some View {
        ZStack {
            QinBackgroundView()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSheet.toggle()
                        if isMoved {
                            Store.shared.dispatch(.playlistOrderUpdateRequesting(ids: ids))
                        }
                    }, label: {
                        QinSFView(systemName: "checkmark", size: .medium)
                    })
                    .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
                }
                .overlay(
                    QinNavigationBarTitleView("管理歌单")
                )
                .padding()
                List {
                    ForEach(playlist) { item in
                        UserPlaylistRowView(playlist: item)
                    }
                    .onDelete(perform: deleteAction)
                    .onMove(perform: moveAction)
                }
                .environment(\.editMode, $editMode)
                .onAppear {
                    ids = playlist.map(\.id)
                }
            }
        }
        .alert(isPresented: $isDeleted) {
            Alert(title: Text("删除歌单"), message: Text("确定删除歌单"), primaryButton: Alert.Button.cancel(Text("取消")), secondaryButton: Alert.Button.destructive(Text("删除"),action: {
                Store.shared.dispatch(.playlistDeleteRequest(pid: Int(deleteId)))
            }))
        }
    }
    func deleteAction(from source: IndexSet) {
        isDeleted = true
        if let index = source.first {
            deleteId = Int64(playlist[index].id)
        }
    }
    func moveAction(from source: IndexSet, offset: Int) {
        isMoved = true
        ids.move(fromOffsets: source, toOffset: offset)
    }
}

#if DEBUG
struct PlaylistManageView_Previews: PreviewProvider {
    @State static var isShow = false
    static var previews: some View {
        PlaylistManageView(showSheet: $isShow)
    }
}
#endif


struct UserPlaylistRowView: View {
   let playlist: NCMPlaylistResponse
    
    var body: some View {
        HStack {
            QinCoverView(playlist.coverImgUrl, style: QinCoverStyle(size: .little, shape: .rectangle))
            VStack(alignment: .leading) {
                Text(playlist.name)
                    .foregroundColor(.mainText)
                Text("\(playlist.trackCount) songs")
                    .foregroundColor(.secondTextColor)
            }
            Spacer()
        }
    }
}
