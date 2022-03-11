//
//  URL+Extension.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 teenloong. All rights reserved.
//

import Foundation

extension URL {
    var fileName: String? {
        guard isFileURL else {
            return nil
        }
        
        return lastPathComponent
    }
    var fileNameWithoutExtension: String? {
        guard isFileURL else {
            return nil
        }
        
        return deletingPathExtension().lastPathComponent
    }
    var fileSize: Int? {
        try? resourceValues(forKeys: [.fileSizeKey]).fileSize
    }
}
