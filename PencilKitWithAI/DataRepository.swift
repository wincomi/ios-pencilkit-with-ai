//
//  DataRepository.swift
//  PencilKitWithAI
//

import Foundation
import PencilKit

final class DataRepository: ObservableObject {
    private var fileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths.first!
        return documentsDirectory.appendingPathComponent("PencilKitWithAI.data")
    }

    @Published var dataModel = DataModel(drawingItems: [])

    init() {
        load()
    }
    
    private func load() {
        let dataModel: DataModel
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: fileURL)
                dataModel = try decoder.decode(DataModel.self, from: data)
            } catch {
                print(error.localizedDescription)
                dataModel = DataModel(drawingItems: [])
            }
        } else {
            dataModel = DataModel(drawingItems: [])
        }
        
        self.dataModel = dataModel
    }
    
    private func save() {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.dataModel)
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func updateDrawing(_ drawing: PKDrawing, at index: Int) {
        dataModel.drawingItems[index].drawing = drawing
        save()
    }
    
    public func update(_ item: DrawingItem) {
        let index = self.dataModel.drawingItems.firstIndex { $0 == item }
        self.dataModel.drawingItems[index!] = item

        save()
    }
    
    public func delete(_ item: DrawingItem) {
        let index = self.dataModel.drawingItems.firstIndex { $0 == item }

        self.dataModel.drawingItems.remove(at: index!)
        save()
    }
    
    public func insertDrawing(_ drawing: PKDrawing = PKDrawing(), name: String = "") {
        let item = DrawingItem(name: name, drawing: drawing)
        dataModel.drawingItems.append(item)
        save()
    }
}
