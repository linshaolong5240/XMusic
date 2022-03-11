//
//  UIDevice+Extension.swift
//  XMusic (iOS)
//
//  Created by teenloong on 2022/3/12.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
    }
}
