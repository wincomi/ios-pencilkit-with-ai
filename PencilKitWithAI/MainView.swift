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
    @State var items = [Item]()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 5), alignment: .leading, spacing: 16) {
                
                ForEach(items) { item in
                    NavigationLink {
                        // push
                    } label: {
                        ImageRow(item: item)
                    }
                }
            }
            .onAppear {
                loadData()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        dataRepository.dataModel.drawings.append(PKDrawing())
                        loadData()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding()

        }
    }

    private func loadData() {
        items = dataRepository.dataModel.drawings.map { Item(image: Image(uiImage: $0.image(from: CGRect(x: 0, y: 0, width: 1024, height: 1024), scale: UIScreen.main.scale))) }
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

