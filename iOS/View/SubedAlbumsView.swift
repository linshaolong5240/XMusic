//
//  AlbumSublistView.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//

import SwiftUI
import NeteaseCloudMusicAPI

struct SubedAlbumsView: View {
    let albums: [NCMAlbumSublistResponse.Album]
    @State private var albumDetailId: Int = 0
    @State private var showAlbumDetail: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: FetchedAlbumDetailView(id: albumDetailId),
                isActive: $showAlbumDetail,
                label: {EmptyView()})
            HStack {
                Text("收藏的专辑")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.mainText)
                Spacer()
                Text("\(albums.count)收藏的专辑")
                    .foregroundColor(Color.secondTextColor)
            }
            .padding(.horizontal)
            ScrollView(Axis.Set.horizontal) {
                let rows: [GridItem] = [.init(.adaptive(minimum: 130))]
                LazyHGrid(rows: rows) /*@START_MENU_TOKEN@*/{
                    ForEach(albums) { item in
                        Button(action: {
                            albumDetailId = Int(item.id)
                            showAlbumDetail.toggle()
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
struct AlbumSublistView_Previews: PreviewProvider {
    static var previews: some View {
        SubedAlbumsView(albums: [NCMAlbumSublistResponse.Album]())
    }
}
#endif
