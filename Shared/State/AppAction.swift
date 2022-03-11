//
//  AppAction.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2020 teenloong. All rights reserved.
//

import Foundation
import NeteaseCloudMusicAPI

enum AppAction {
    case initAction
    case InitMPRemoteControl
    case albumDetailRequest(id: Int)
    case albumDetailRequestDone(result: Result<[Int], AppError>)
    case albumSubRequest(id: Int, sub: Bool)
    case albumSubRequestDone(result: Result<Bool, AppError>)
    case albumSublistRequest(limit: Int = 999, offset: Int = 0)
    case albumSublistRequestDone(result: Result<NCMAlbumSublistResponse, AppError>)
    case artistDetailRequest(id: Int)
    case artistDetailRequestDone(result: Result<[Int], AppError>)
    case artistAlbumsRequest(id: Int, limit: Int = 999, offset: Int = 0)
    case artistAlbumsRequestDone(result: Result<[Int], AppError>)
    case artistMVsRequest(id: Int, limit: Int = 999, offset: Int = 0, total: Bool = true)
    case artistMVsRequestDone(result: Result<NCMArtistMVResponse, AppError>)
    case artistSubRequest(id: Int, sub: Bool)
    case artistSubRequestDone(result: Result<Bool, AppError>)
    case artistSublistRequest(limit: Int = 999, offset: Int = 0)
    case cloudSongAddRequst(songId: Int)
    case cloudSongAddRequstDone(result: Result<NCMCloudSongAddResponse, AppError>)
    case cloudUploadCheckRequest(fileURL: URL)
    case cloudUploadCheckRequestDone(result: Result<(response: NCMCloudUploadCheckResponse, md5: String), AppError>)
    case cloudUploadInfoRequest(NCMCloudUploadInfoAction.Parameters)
    case cloudUploadInfoRequestDone(result: Result<NCMCloudUploadInfoAction.Response, AppError>)
    case cloudUploadSongRequest(token: CloudUploadTokenResponse.Result, md5: String, size: Int, data: Data)
    case cloudUploadTokenRequest(fileURL: URL, md5: String)
    case cloudUploadTokenRequestDone(result: Result<CloudUploadTokenResponse.Result, AppError>)
    case artistSublistRequestDone(result: Result<NCMArtistSublistResponse, AppError>)
    case commentRequest(id: Int = 0, commentId: Int? = nil, content: String? = nil, type: NCMCommentType, action: NCMCommentAction)
    case commentDoneRequest(result: Result<(id: Int, type: NCMCommentType, action: NCMCommentAction), AppError>)
    case commentLikeRequest(id: Int, cid: Int, like: Bool, type: NCMCommentType)
    case commentLikeDone(result: Result<Int, AppError>)
    case commentMusicRequest(rid: Int, limit: Int = 20, offset: Int = 0, beforeTime: Int = 0)
    case commentMusicRequestDone(result: Result<NCMCommentSongResponse, AppError>)
    case commentMusicLoadMoreRequest
    case coverShape
    case error(AppError)
    case loginRequest(email: String, password: String)
    case loginRequestDone(result: Result<NCMLoginResponse, AppError>)
    case loginRefreshRequest
    case loginRefreshRequestDone(result: Result<Bool, AppError>)
    case logoutRequest
    case logoutRequestDone(result: Result<Int, AppError>)
    case mvDetailRequest(id: Int)
    case mvDetaillRequestDone(result: Result<Int, AppError>)
    case mvURLRequest(id: Int)
//    case mvUrlDone(result: Result<String, AppError>)
    case playerPause
    case playerPlay
    case playerPlayBackward
    case playerPlayBy(index: Int)
    case playerPlayForward
    case playerPlayMode
    case playerPlayRequest(id: Int)
    case playerPlayRequestDone(result: Result<String?, AppError>)
    case PlayerPlaySongs(songs: [QinSong])
    case PlayerPlayToendAction
    case playerReplay
    case playerSeek(isSeeking: Bool, time: Double)
    case playerTogglePlay(song: QinSong)
    case playinglistInsertAndPlay(songs: [QinSong])
    case playlistCatalogueRequest
    case playlistCatalogueRequestsDone(result: Result<[PlaylistCatalogue], AppError>)
    case playlistCreateRequest(name: String, privacy: NCMPlaylistCreateAction.Privacy = .common)
    case playlistCreateRequestDone(result: Result<Int, AppError>)
    case playlistDeleteRequest(pid: Int)
    case playlistDeleteRequestDone(result: Result<Int, AppError>)
    case playlistDetailRequest(id: Int)
    case playlistDetailRequestDone(result: Result<NCMPlaylistResponse, AppError>)
    case playlistDetailSongsRequest(playlist: NCMPlaylistResponse)
    case playlistDetailSongsRequestDone(result: Result<[Int], AppError>)
    case playlistOrderUpdateRequesting(ids: [Int])
    case playlistOrderUpdateDone(result: Result<Bool, AppError>)
    case playlistSubscibeRequest(id: Int, sub: Bool)
    case playlistSubscibeRequestDone(result: Result<Int, AppError>)
    case playlistTracksRequest(pid: Int, ids: [Int], op: Bool)
    case playlistTracksRequestDone(result: Result<Int, AppError>)
    case recommendPlaylistRequest
    case recommendPlaylistRequestDone(result: Result<NCMRecommendPlaylistResponse, AppError>)
    case recommendSongsRequest
    case recommendSongsRequestDone(result: Result<[Int], AppError>)
    case songLikeRequest(id: Int, like: Bool)
    case songLikeRequestDone(result: Result<Bool, AppError>)
    case songLikeListRequest(uid: Int? = nil)
    case songLikeListRequestDone(result: Result<[Int], AppError>)
    case songlyricRequest(id: Int)
    case songlyricRequestDone(result: Result<NCMSongLyricResponse, AppError>)
    case songsDetailRequest(ids: [Int])
    case songsDetailRequestDone(result: Result<[Int], AppError>)
    case songsOrderUpdateRequesting(pid: Int, ids: [Int])
    case songsOrderUpdateRequestDone(result: Result<Int, AppError>)
    case songsURLRequest(ids: [Int])
    case songsURLRequestDone(result: Result<NCMSongURLResponse, AppError>)
    case updateMPNowPlayingInfo
    case userCloudRequest
    case userPlaylistRequest(uid: Int? = nil, limit: Int = 999, offset: Int = 0)
    case userPlaylistRequestDone(result: Result<[NCMPlaylistResponse], AppError>)
}
