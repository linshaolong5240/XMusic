//
//  LyricParser.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2020 teenloong. All rights reserved.
//

import Foundation

class LyricParser {
    private(set) var lyric: String
    private var times = [[Double]]()
    var lyrics = [String]()
    
    init(lyric: String) {
        self.lyric = lyric
        if lyric.count > 0 {
            parseLyric()
        }
    }
    
    private func parseLyric() {
        let data = lyric.split(separator: "\n")
            .map { subStr -> ([Double], String) in
                let lyricLine = String(subStr)
                var times = [Double]()
                var lyricString = ""
//                let pattern = "\\[\\d+:\\d+.\\d+\\]"
                let pattern = "\\d+:\\d+.\\d+"

                do {
                    let Regular = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
                    let result = Regular.matches(in: lyricLine, options: [], range: NSRange(location: 0, length: lyricLine.count))
                    for r in result {
                        if let range = Range(r.range, in: lyricLine) {
                            let timeStr = lyricLine[range]
                            let timesStr = timeStr.split(separator: ":")
                            times.append(Double(timesStr[0])! * 60 + Double(timesStr[1])!)
                        }
                    }
                    if result.count > 0 {
                        if let range = Range(result[result.count - 1].range, in: lyricLine) {
                            let index = lyricLine.index(after: range.upperBound)
                            lyricString = String(lyricLine[index...])
                        }
                    }
                }
                catch let error {
                    print(error)
                }
                return (times, lyricString)
            }
            .filter{ (times, _) -> Bool in
                return times.count > 0 ? true : false
            }
//        print(data)
        times = data.map { (times, _) in
            times
        }
        lyrics = data.map{ (_, lyric) in
            lyric
        }
//        print(times)
//        print(lyrics)
    }
    
    func lyricByTime(_ time: Double, offset: Double = 0.0) -> (String, Int) {
        var lyric = ""
        var i: Int = -1
        var index: Int = 0
        var delta: Double = 10 * 60.0
        
        guard time >= 0 && times.count > 0 else {
            return (lyric, index)
        }
        
        for ts in times {
            i += 1
            for t in ts {
                if abs(time - t) < delta && time > (t + offset) {
                    delta = abs(time - t)
                    lyric = lyrics[i]
                    index = i
                }
            }
        }
        return (lyric, index)
    }
}
