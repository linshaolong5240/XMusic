//
//  CreatedPlaylistView.swift
//  XMusic (iOS)
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import NeumorphismSwiftUI
import NeteaseCloudMusicAPI

struct CreatedPlaylistView: View {
    let playlist: [NCMPlaylistResponse]
    @State private var playlistDetailId: Int = 0
    @State private var showPlaylistDetail: Bool = false
    @State private var showPlaylistCreate: Bool = false
    @State private var showPlaylistManage: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FetchedPlaylistDetailView(id: playlistDetailId),
                isActive: $showPlaylistDetail,
                label: {EmptyView()})
            HStack {
                Text("创建的歌单")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.mainText)
                Text("(\(playlist.count))")
                    .foregroundColor(Color.mainText)
                Spacer()
                Button(action: {
                    showPlaylistManage.toggle()
                }) {
                    QinSFView(systemName: "lineweight", size:  .small)
                        .sheet(isPresented: $showPlaylistManage) {
                            PlaylistManageView(showSheet: $showPlaylistManage)
                                .environment(\.managedObjectContext, DataManager.shared.context())//sheet 需要传入父环境
                        }
                }
                .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
                Button(action: {
                    showPlaylistCreate.toggle()
                }) {
                    QinSFView(systemName: "folder.badge.plus", size:  .small)
                        .sheet(isPresented: $showPlaylistCreate) {
                            PlaylistCreateView(showSheet: $showPlaylistCreate)
                        }
                }
                .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
            }
            .padding(.horizontal)
            ScrollView(Axis.Set.horizontal, showsIndicators: true) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) /*@START_MENU_TOKEN@*/{
                    ForEach(playlist) { (item) in
                        Button(action: {
                            playlistDetailId = item.id
                            showPlaylistDetail.toggle()
                        }, label: {
                            CommonGridItemView(item)
                                .padding(.vertical)
                        })
                    }
                }/*@END_MENU_TOKEN@*/
            }
        }
    }
}

#if DEBUG
struct CreatedPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CreatedPlaylistView(playlist: [])
            .environmentObject(Store.shared)
            .preferredColorScheme(.light)
        CreatedPlaylistView(playlist: [])
            .environmentObject(Store.shared)
            .preferredColorScheme(.dark)
    }
}
#endif

struct PlaylistCreateView: View {
    @EnvironmentObject private var store: Store
    @Binding var showSheet: Bool
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            QinBackgroundView()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        QinSFView(systemName: "checkmark", size:  .medium)
                    })
                    .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
                }
                .padding()
                .overlay(
                    Text("创建歌单")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.mainText)
                )
                TextField("歌单名", text: $name)
                    .textFieldStyle(NEUDefaultTextFieldStyle(label: Image(systemName: "folder.badge.plus").foregroundColor(.mainText)))
                    .padding()
                Button(action: {
                    showSheet.toggle()
                    Store.shared.dispatch(.playlistCreateRequest(name: name))
                }){
                    HStack(spacing: 0.0) {
                        QinSFView(systemName: "folder.badge.plus", size: .medium)
                            .padding(.horizontal)
                    }
                }
                .buttonStyle(NEUDefaultButtonStyle(shape: Capsule()))
                Spacer()
            }
        }
    }
}
