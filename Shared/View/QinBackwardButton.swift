//
//  XMusicBackwardButton.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import NeumorphismSwiftUI

public struct QinBackwardButton: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    public var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            QinSFView(systemName: "chevron.backward" ,size: .medium)
        }
        .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
    }
}

#if DEBUG
struct QinBackwardButton_Previews: PreviewProvider {
    static var previews: some View {
        QinBackwardButton()
    }
}
#endif
