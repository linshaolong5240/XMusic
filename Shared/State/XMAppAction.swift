//
//  XMAppAction.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 teenloong. All rights reserved.
//

import Foundation
import NeteaseCloudMusicAPI

enum XMAppAction {
    case initAction
    case InitMPRemoteControl
    case albumDetailRequest(id: Int)
    case albumDetailRequestDone(result: Result<[Int], XMAppError>)
    case albumSubRequest(id: Int, sub: Bool)
    case albumSubRequestDone(result: Result<Bool, XMAppError>)
    case albumSublistRequest(limit: Int = 999, offset: Int = 0)
    case albumSublistRequestDone(result: Result<NCMAlbumSublistResponse, XMAppError>)
    case artistDetailRequest(id: Int)
    case artistDetailRequestDone(result: Result<[Int], XMAppError>)
    case artistAlbumsRequest(id: Int, limit: Int = 999, offset: Int = 0)
    case artistAlbumsRequestDone(result: Result<[Int], XMAppError>)
    case artistMVsRequest(id: Int, limit: Int = 999, offset: Int = 0, total: Bool = true)
    case artistMVsRequestDone(result: Result<NCMArtistMVResponse, XMAppError>)
    case artistSubRequest(id: Int, sub: Bool)
    case artistSubRequestDone(result: Result<Bool, XMAppError>)
    case artistSublistRequest(limit: Int = 999, offset: Int = 0)
    case cloudSongAddRequst(songId: Int)
    case cloudSongAddRequstDone(result: Result<NCMCloudSongAddResponse, XMAppError>)
    case cloudUploadCheckRequest(fileURL: URL)
    case cloudUploadCheckRequestDone(result: Result<(response: NCMCloudUploadCheckResponse, md5: String), XMAppError>)
    case cloudUploadInfoRequest(NCMCloudUploadInfoAction.Parameters)
    case cloudUploadInfoRequestDone(result: Result<NCMCloudUploadInfoAction.Response, XMAppError>)
    case cloudUploadSongRequest(token: CloudUploadTokenResponse.Result, md5: String, size: Int, data: Data)
    case cloudUploadTokenRequest(fileURL: URL, md5: String)
    case cloudUploadTokenRequestDone(result: Result<CloudUploadTokenResponse.Result, XMAppError>)
    case artistSublistRequestDone(result: Result<NCMArtistSublistResponse, XMAppError>)
    case commentRequest(id: Int = 0, commentId: Int? = nil, content: String? = nil, type: NCMCommentType, action: NCMCommentAction)
    case commentDoneRequest(result: Result<(id: Int, type: NCMCommentType, action: NCMCommentAction), XMAppError>)
    case commentLikeRequest(id: Int, cid: Int, like: Bool, type: NCMCommentType)
    case commentLikeDone(result: Result<Int, XMAppError>)
    case commentMusicRequest(rid: Int, limit: Int = 20, offset: Int = 0, beforeTime: Int = 0)
    case commentMusicRequestDone(result: Result<NCMCommentSongResponse, XMAppError>)
    case commentMusicLoadMoreRequest
    case coverShape
    case error(XMAppError)
    case loginRequest(email: String, password: String)
    case loginRequestDone(result: Result<NCMLoginResponse, XMAppError>)
    case loginRefreshRequest
    case loginRefreshRequestDone(result: Result<Bool, XMAppError>)
    case logoutRequest
    case logoutRequestDone(result: Result<Int, XMAppError>)
    case mvDetailRequest(id: Int)
    case mvDetaillRequestDone(result: Result<Int, XMAppError>)
    case mvURLRequest(id: Int)
//    case mvUrlDone(result: Result<String, AppError>)
    case playerPause
    case playerPlay
    case playerPlayBackward
    case playerPlayBy(index: Int)
    case playerPlayForward
    case playerPlayMode
    case playerPlayRequest(id: Int)
    case playerPlayRequestDone(result: Result<String?, XMAppError>)
    case PlayerPlaySongs(songs: [QinSong])
    case PlayerPlayToendAction
    case playerReplay
    case playerSeek(isSeeking: Bool, time: Double)
    case playerTogglePlay(song: QinSong)
    case playinglistInsertAndPlay(songs: [QinSong])
    case playlistCatalogueRequest
    case playlistCatalogueRequestsDone(result: Result<[PlaylistCatalogue], XMAppError>)
    case playlistCreateRequest(name: String, privacy: NCMPlaylistCreateAction.Privacy = .common)
    case playlistCreateRequestDone(result: Result<Int, XMAppError>)
    case playlistDeleteRequest(pid: Int)
    case playlistDeleteRequestDone(result: Result<Int, XMAppError>)
    case playlistDetailRequest(id: Int)
    case playlistDetailRequestDone(result: Result<NCMPlaylistResponse, XMAppError>)
    case playlistDetailSongsRequest(playlist: NCMPlaylistResponse)
    case playlistDetailSongsRequestDone(result: Result<[Int], XMAppError>)
    case playlistOrderUpdateRequesting(ids: [Int])
    case playlistOrderUpdateDone(result: Result<Bool, XMAppError>)
    case playlistSubscibeRequest(id: Int, sub: Bool)
    case playlistSubscibeRequestDone(result: Result<Int, XMAppError>)
    case playlistTracksRequest(pid: Int, ids: [Int], op: Bool)
    case playlistTracksRequestDone(result: Result<Int, XMAppError>)
    case recommendPlaylistRequest
    case recommendPlaylistRequestDone(result: Result<NCMRecommendPlaylistResponse, XMAppError>)
    case recommendSongsRequest
    case recommendSongsRequestDone(result: Result<[Int], XMAppError>)
    case songLikeRequest(id: Int, like: Bool)
    case songLikeRequestDone(result: Result<Bool, XMAppError>)
    case songLikeListRequest(uid: Int? = nil)
    case songLikeListRequestDone(result: Result<[Int], XMAppError>)
    case songlyricRequest(id: Int)
    case songlyricRequestDone(result: Result<NCMSongLyricResponse, XMAppError>)
    case songsDetailRequest(ids: [Int])
    case songsDetailRequestDone(result: Result<[Int], XMAppError>)
    case songsOrderUpdateRequesting(pid: Int, ids: [Int])
    case songsOrderUpdateRequestDone(result: Result<Int, XMAppError>)
    case songsURLRequest(ids: [Int])
    case songsURLRequestDone(result: Result<NCMSongURLResponse, XMAppError>)
    case updateMPNowPlayingInfo
    case userCloudRequest
    case userPlaylistRequest(uid: Int? = nil, limit: Int = 999, offset: Int = 0)
    case userPlaylistRequestDone(result: Result<[NCMPlaylistResponse], XMAppError>)
}
