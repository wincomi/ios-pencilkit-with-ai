//
//  ImageRow.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import SwiftUI

struct ImageRow: View {
    @State var item: DrawingItem
    
    var body: some View {
        VStack {
            Image(uiImage: item.image())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 256, height: 256)
                .padding()
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 1, x: 0, y: 0)
            Text(item.name == "" ? "제목 없음" : item.name)
                .foregroundColor(Color(uiColor: .label))
        }
    }
}
