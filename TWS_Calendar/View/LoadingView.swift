//
//  LoadingView.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/30.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.6)
            ProgressView("")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
