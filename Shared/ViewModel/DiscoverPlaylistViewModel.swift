//
//  DiscoverPlaylistViewModel.swift
//  XMuisc
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Combine
import NeteaseCloudMusicAPI

struct PlaylistCatalogue: Identifiable {
    public var id: Int
    public let name: String
    public let subs: [String]
}

extension NCMPlaylistResponse: Identifiable {
    
}

class DiscoverPlaylistViewModel: ObservableObject {
    var cancell = AnyCancellable({})
        
    @Published var requesting = false
    var catalogue: [PlaylistCatalogue]
    @Published var playlists = [NCMPlaylistResponse]()
    
    init(catalogue: [PlaylistCatalogue]) {
        self.catalogue = catalogue
    }
    
    func playlistRequest(cat: String) {
        cancell = NCM.requestPublisher(action: NCMPlaylistCategoryListAction(category: cat, order: .hot, limit: 30, offset: 0 * 30, total: true))
            .sink { completion in
                if case .failure(let error) = completion {
                    Store.shared.dispatch(.error(.error(error)))
                }
            } receiveValue: {[weak self] playlistListResponse in
                self?.playlists = playlistListResponse.playlists
            }
    }
}
