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

    var dataModel = DataModel()
        
    init() {
        loadDataModel()
    }
    
    func loadDataModel() {
        let dataModel: DataModel
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: fileURL)
                dataModel = try decoder.decode(DataModel.self, from: data)
            } catch {
                print(error.localizedDescription)
                dataModel = DataModel()
            }
        } else {
            dataModel = DataModel()
        }
        
        self.dataModel = dataModel
    }
    
    func saveDataModel() {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.dataModel)
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateDrawing(_ drawing: PKDrawing, at index: Int) {
        dataModel.drawings[index] = drawing
        saveDataModel()
        print("updateDrawing")
    }
}
