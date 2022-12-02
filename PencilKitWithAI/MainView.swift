//
//  MainView.swift
//  PencilKitWithAI
//
//  Created by dale on 2022/12/03.
//

import SwiftUI
import PencilKit

struct MainView: View {
    @EnvironmentObject var dataRepository: DataRepository

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 5), alignment: .leading, spacing: 16) {
                ForEach(dataRepository.dataModel.drawingItems) { item in
                    NavigationLink {
                        // push
                    } label: {
                        ImageRow(item: item)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        dataRepository.insertDrawing()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding()

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
        }
        .navigationViewStyle(.stack)
        .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct Item: Identifiable {
    let id: UUID = .init()

    var image: Image
}

