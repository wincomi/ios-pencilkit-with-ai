//
//  DataRepository.swift
//  PencilKitWithAI
//

import Foundation
import PencilKit
import RxCocoa

final class DataRepository {
    private var fileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths.first!
        return documentsDirectory.appendingPathComponent("PencilKitWithAI.data")
    }

    var dataModel = PublishRelay<DataModel>()
    
    init() {
        loadDataModel()
    }
    
    private func loadDataModel() {
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
        
        self.dataModel.accept(dataModel)
    }
}
